import 'dart:math';

import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

class ChatWithAi extends StatefulWidget {
  const ChatWithAi({super.key});

  @override
  ChatWithAiState createState() => ChatWithAiState();
}

class ChatWithAiState extends State<ChatWithAi> {
  final _chatController = InMemoryChatController();
  String userPersonalizationData = '';
  List<Map<String, dynamic>> messagesHistory = [
    {
      'id': '1',
      'authorId': 'user1',
      'createdAt': DateTime.now().toUtc(),
      'text': 'Hello, how can I help you today?',
    },
    {
      'id': '2',
      'authorId': 'user2',
      'createdAt': DateTime.now().toUtc(),
      'text': 'I need help with my account.',
    },
    {
      'id': '3',
      'authorId': 'user1',
      'createdAt': DateTime.now().toUtc(),
      'text': 'Sure, what seems to be the problem?',
    },
    {
      'id': '4',
      'authorId': 'user1',
      'createdAt': DateTime.now().toUtc(),
      'text': 'Sure, what seems to be the problem?',
    },
    {
      'id': '5',
      'authorId': 'user2',
      'createdAt': DateTime.now().toUtc(),
      'text': 'I forgot my password.',
    },
    {
      'id': '6',
      'authorId': 'user1',
      'createdAt': DateTime.now().toUtc(),
      'text': 'No problem, I can help you with that.',
    },
    {
      'id': '7',
      'authorId': 'user2',
      'createdAt': DateTime.now().toUtc(),
      'text': 'Thank you!',
    },
    {
      'id': '8',
      'authorId': 'user1',
      'createdAt': DateTime.now().toUtc(),
      'text': 'You are welcome!',
    },
    {
      'id': '9',
      'authorId': 'user1',
      'createdAt': DateTime.now().toUtc(),
      'text': 'You are welcome!',
    },
  ];
  @override
  void initState() {
    // Initialize the chat controller with the messages history
    for(final i in messagesHistory){
      _chatController.insertMessage(
        TextMessage(
          id: i['id'],
          authorId: i['authorId'],
          text: i['text'],
          createdAt: i['createdAt'],
        )
      );
    }
    // Get user personalization data
    userPersonalizationData = context.read<AppViewModel>().userPersonalizationDataForChatBot.data.toString();
    super.initState();
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
        currentUserId: 'user1',
        onMessageSend: (text) {
          _chatController.insertMessage(
            TextMessage(
              // Better to use UUID or similar for the ID - IDs must be unique
              id: '${Random().nextInt(1000) + 1}',
              authorId: 'user1',
              createdAt: DateTime.now().toUtc(),
              text: text,
            ),
          );
          // Simulate a response from the AI
          Future.delayed(const Duration(seconds: 1), () {
            _chatController.insertMessage(
              TextMessage(
                id: '${Random().nextInt(1000) + 1}',
                authorId: 'user2',
                createdAt: DateTime.now().toUtc(),
                text: userPersonalizationData,
              ),
            );
          });
        },
        resolveUser: (UserID id) async {
          return User(id: id, name: 'John Doe');
        },
        decoration: BoxDecoration(

        ),
        builders: Builders(

        ),


      ),
    );
  }
}