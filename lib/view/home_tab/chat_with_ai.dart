import 'dart:convert';
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatWithAi extends StatefulWidget {
  const ChatWithAi({super.key});

  @override
  ChatWithAiState createState() => ChatWithAiState();
}

class ChatWithAiState extends State<ChatWithAi> {
  final _chatController = InMemoryChatController();
  final AppViewModel _appViewModel = AppViewModel();
  final SharedPreferences _sharedPreferences = locator<SharedPreferences>();
  var uuid = Uuid();
  String userId = 'user';
  String chatbotId = 'chatbot';

  List<Map<String, dynamic>> messagesHistory = [];
  Future<void> saveChatHistory({required String userMessage, required String chatbotMessage, required String userMessageId, required String chatbotMessageId}) async{
    Map<String, dynamic> newUserMessage = {
      'id': userMessageId,
      'authorId': userId,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'text': userMessage,
    };
    Map<String, dynamic> newChatBotMessage = {
      'id': chatbotMessageId,
      'authorId': chatbotId,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'text': chatbotMessage,
    };
    messagesHistory.add(newUserMessage);
    messagesHistory.add(newChatBotMessage);

    // Save the updated messages history to shared preferences
    await _sharedPreferences.setString('conversationHistoryWithAI', jsonEncode(messagesHistory));
  }

  Map<String, dynamic> dataToSubmit = {
    'chatHistory': [],
    'chatContent': ''
  };

  @override
  void initState() {
    super.initState();

    // Load messages history from shared preferences if available
    String? conversationHistory = _sharedPreferences.getString('conversationHistoryWithAI');
    if(conversationHistory != null) {
      List<dynamic> result = jsonDecode(conversationHistory);
      messagesHistory = List<Map<String, dynamic>>.from(result);
    }else{
      _chatController.insertMessage(
        TextMessage(
          id: uuid.v4(),
          authorId: chatbotId,
          text: 'Hello! How can I assist you today?',
          createdAt: DateTime.now().toUtc(),
        )
      );
    }

    // Initialize the chat controller with the messages history
    for(final i in messagesHistory){
      _chatController.insertMessage(
        TextMessage(
          id: i['id'],
          authorId: i['authorId'],
          text: i['text'],
          createdAt: DateTime.parse( i['createdAt']),
        )
      );
    }
    // Get user personalization data
    ApiResponse userPersonalizationData = context.read<AppViewModel>().userPersonalizationDataForChatBot;
    if(userPersonalizationData.status == Status.COMPLETED){
      dataToSubmit['userData'] = userPersonalizationData.data;
      Set<String> keys = _sharedPreferences.getKeys();
      if(keys.contains('historyChatWithAi')) {
        String conversationHistory = _sharedPreferences.getString('historyChatWithAi') ?? '';
        List<dynamic> conversationHistoryList = List<dynamic>.from(jsonDecode(conversationHistory));
        dataToSubmit['chatHistory'] = conversationHistoryList;
      }
    }
  }


  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI'),
        leading: const CustomBackNavbar(),
      ),
      backgroundColor: primaryColor,
      body: Chat(
        chatController: _chatController,
        currentUserId: userId,
        onMessageSend: (text) async{
          String userMessageId = uuid.v4();
          String chatbotMessageId = uuid.v4();
          dataToSubmit['chatContent'] = text;
          _chatController.insertMessage(
            TextMessage(
              id: userMessageId,
              authorId: userId,
              createdAt: DateTime.now().toUtc(),
              text: text,
            ),
          );
          dynamic result = await _appViewModel.chatWithAi(dataToSubmit, context);
          dataToSubmit['chatHistory'] = result;
          await _sharedPreferences.setString('historyChatWithAi', jsonEncode(result));
          String responseText = result[result.length - 1];
          await saveChatHistory(
            userMessage: text,
            chatbotMessage: responseText,
            userMessageId: userMessageId,
            chatbotMessageId: chatbotMessageId,
          );
          // Simulate a response from the AI
          Future.delayed(const Duration(seconds: 1), () {
            _chatController.insertMessage(
              TextMessage(
                id: chatbotMessageId,
                authorId: chatbotId,
                createdAt: DateTime.now().toUtc(),
                text: responseText,
              ),
            );
          });
        },
        resolveUser: (UserID id) async {
          return User(id: id, name: 'John Doe');
        },
        decoration: BoxDecoration(),
        builders: Builders(),


      ),
    );
  }
}