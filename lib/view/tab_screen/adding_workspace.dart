
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/utils/format_number.dart';
import 'package:fe_financial_manager/utils/get_initial_data.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/date_option_bottom_sheets.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/expanded_area.dart';
import 'package:fe_financial_manager/view/common_widget/custom_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_float_action_button.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/prefix_icon_amount_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key, this.transactionToUpdate});
  final TransactionHistoryModel ? transactionToUpdate;
  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}
class _AddingWorkspaceState extends State<AddingWorkspace> {

  Map<String, dynamic> dataToSubmit = {};
  final TextEditingController _amountController = TextEditingController();
  String chosenDateOccurTransaction = '';
  String nameOfTheDay = '';
  // Note
  String note = '';
  // Pick category
  PickedIconModel pickedCategory = PickedIconModel(icon: '', name: '', id: '') ;
  PickedIconModel pickedWallet = PickedIconModel(icon: '', name: '', id: '') ;

  void getDate(){
    // return 'Monday,  2025-03-19T20:31:38';
    if(widget.transactionToUpdate != null){
      chosenDateOccurTransaction = DateTimeHelper.convertDateTimeToIsoString(widget.transactionToUpdate?.occurDate ?? DateTime.now());
      nameOfTheDay= DateTimeHelper.getNameOfDay(chosenDateOccurTransaction);
    }else {
      chosenDateOccurTransaction = DateTimeHelper.getCurrentDayMonthYear();
      nameOfTheDay= DateTimeHelper.getNameOfDay(DateTimeHelper.getCurrentDayMonthYear());
    }

  }
  String fromIsoToNormal(){
    return DateTime.parse(chosenDateOccurTransaction).toIso8601String().split('T')[0];
  }
  void resetDataAfterSaveTransaction(){
    setState(() {
      _amountController.text = '';
      note = '';
    });
  }

  // Action when item of category tapped
  Future<void> onItemCategoryTap(PickedIconModel value)async {
    setState(() {
      pickedCategory = value;
    });
    context.pop();
  }
  Future<void> onItemWalletTap(PickedIconModel value)async {
    setState(() {
      pickedWallet = value;
    });
    context.pop();
  }
  // Save transaction
  Future <void> saveTransaction() async {

    if(_amountController.text.isEmpty){
      Utils.flushBarErrorMessage('Amount is not empty', context);
      return;
    }
    // event_id, related_party, reminder_date
    dataToSubmit = {
      'amount_of_money' : FormatNumber.cleanedNumber(_amountController.text),
      'transaction_type_category_id' : pickedCategory.id,
      'occur_date' : chosenDateOccurTransaction,
      'money_account_id' : pickedWallet.id,
      'description' : note,
    };
    if(widget.transactionToUpdate != null && widget.transactionToUpdate!.id.isNotEmpty){
      dataToSubmit['id'] = widget.transactionToUpdate!.id;
      await context.read<TransactionViewModel>().updateTransaction(dataToSubmit ,context);
    }else {
      await context.read<TransactionViewModel>().addTransaction(dataToSubmit, resetDataAfterSaveTransaction ,context);
    }
    await context.read<AppViewModel>().getUserPersonalizationDataForChatBot(context);
  }


  @override
  void initState() {
    if(widget.transactionToUpdate != null){
      pickedWallet = PickedIconModel(
        icon: widget.transactionToUpdate!.moneyAccount.walletTypeIconPath,
        name: widget.transactionToUpdate!.moneyAccount.name,
        id: widget.transactionToUpdate!.moneyAccount.id,
      );
      pickedCategory = PickedIconModel(
        icon: widget.transactionToUpdate!.transactionTypeCategory.icon,
        name: widget.transactionToUpdate!.transactionTypeCategory.name,
        id: widget.transactionToUpdate!.transactionTypeCategory.id,
      );
      _amountController.text = FormatNumber.format(widget.transactionToUpdate!.amountOfMoney.toString());
      note = widget.transactionToUpdate?.description ?? '';
      getDate();
    }else {
      final WalletViewModel walletViewModel = Provider.of<WalletViewModel>(context, listen: false);
      final List<dynamic> listWalletData = walletViewModel.allWalletData.data ?? [];

      final AppViewModel appViewModel = Provider.of<AppViewModel>(context, listen: false);
      final List<dynamic> listCategoriesData = appViewModel.iconCategoriesData.data?.categoriesIconListMap['expense'] ?? [];

      // Get initial wallet
      getInitialData((data){
        setState(() {
          pickedWallet = data;
        });
      }, listWalletData, context);

      // Get initial transaction categories
      getInitialData((data){
        setState(() {
          pickedCategory = data;
        });
      }, listCategoriesData, context);

      getDate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dividerIndent = screenHeight * 0.094;
    return Consumer<TransactionViewModel>(
      builder: (BuildContext context,  value, Widget? child) {
        return LoadingOverlay(
          isLoading: value.loading,
          child: Scaffold(
            key: const ValueKey('addingWorkspaceTab'),
            appBar: AppBar(
              title: const Text('Add Transaction'),
              actions: [
                Visibility(
                  visible: widget.transactionToUpdate != null && widget.transactionToUpdate!.id.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SvgContainer(
                      callback: ()async{
                        await context.read<TransactionViewModel>().deleteTransaction(
                            widget.transactionToUpdate!.id, context);
                      },
                      iconWidth: 28,
                      iconPath: Assets.svgTrash,
                      myIconColor: emergencyColor,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.transactionToUpdate == null,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SvgContainer(
                      callback: ()async{
                        await context.read<TransactionViewModel>().uploadImage(context);
                      },
                      iconWidth: 28,
                      iconPath: Assets.svgImage,
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton: MyFloatActionButton(
              callback: () async{
                await saveTransaction();
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  //Pick wallets
                  MyListTitle(
                    callback: () async{
                      dynamic result = await context.push(
                          FinalRoutes.selectWalletPath,
                          extra: {
                            'pickedWallet': pickedWallet,
                            'onTap' : onItemWalletTap
                          }
                      );
                      if(result != null){
                        pickedWallet = result;
                      }
                    },
                    title: pickedWallet.name.isEmpty ? 'Choose Wallet' : pickedWallet.name,
                    leading: pickedWallet.icon.isEmpty ?
                    Image.asset('assets/another_icon/wallet-2.png', width: defaultLeadingPngListTileSize) :
                    Image.asset(pickedWallet.icon, width: defaultLeadingPngListTileSize),
                  ),
                  MyDivider(indent: dividerIndent),
                  //Pick amount
                  CustomTextfield(
                    controller: _amountController,
                    textInputType: TextInputType.number,
                    prefixIcon: const PrefixIconAmountTextfield(),
                    fontSize: 40,
                    hintText: '0',
                    prefixIconPadding: const EdgeInsets.only(right: 11, left: 10),
                  ),
                  MyDivider(indent: dividerIndent),
                  //Pick category
                  MyListTitle(
                    key: const ValueKey('pickCategory'),
                    title: pickedCategory.name.isNotEmpty ? pickedCategory.name:  'Select category' ,
                    titleTextStyle: const TextStyle(
                        fontSize: extraBigger,
                        color: colorTextLabel,
                        fontWeight: FontWeight.w500
                    ),
                    callback: () {
                      context.push(
                          FinalRoutes.pickCategoryPath,
                          extra: {
                            'pickedCategory': pickedCategory,
                            'onTap' : onItemCategoryTap
                          }
                      );
                    },
                    verticalContentPadding: 4,
                    leading: FittedBox(
                      child: Image.asset(
                        pickedCategory.icon.isNotEmpty ?
                        pickedCategory.icon: 'assets/another_icon/category.png',
                        width: 39,
                      ),
                    ),
                  ),
                  MyDivider(indent: dividerIndent),
                  //Pick note
                  MyListTitle(
                    callback: () async {
                      final dynamic result =
                      await context.push<String>(
                          FinalRoutes.addNotePath , extra: note);
                      setState(() {
                        note = result;
                      });
                    },
                    title: note.isNotEmpty ? note : 'Note',
                    leading: SvgContainer(
                        iconWidth: 30,
                        iconPath: Assets.svgNotes
                    ),
                    horizontalTitleGap: 18,
                  ),
                  MyDivider(indent: dividerIndent),
                  //Pick date
                  MyListTitle(
                    callback: () {
                      showDateOptionBottomSheet(context, (value){
                        // prevent unnecessary re-render
                        if(chosenDateOccurTransaction == value){
                          return;
                        }
                        setState(() {
                          chosenDateOccurTransaction = value;
                          nameOfTheDay= DateTimeHelper.getNameOfDay(chosenDateOccurTransaction);
                        });
                      });
                    },
                    title: '$nameOfTheDay, ${fromIsoToNormal()}',
                    leading: SvgContainer(
                        iconWidth: 28,
                        iconPath: Assets.svgCalendar
                    ),
                    horizontalTitleGap: 18,
                  ),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  const ExpandedArea(),
                  const SizedBox(height: 20,),
                  // _image == null ? Text('Chưa có ảnh nào.') : Image.file(_image!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

