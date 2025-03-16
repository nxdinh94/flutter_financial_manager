
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/utils/get_initial_wallet.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/date_option_bottom_sheets.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/expanded_area.dart';
import 'package:fe_financial_manager/view/common_widget/custom_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_float_action_button.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/prefix_icon_amount_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/transaction_categories_icon_model.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}
class _AddingWorkspaceState extends State<AddingWorkspace> {
  final TextEditingController _amountController = TextEditingController();
  String chosenDateOccurTransaction = '';
  String nameOfTheDay = '';
  // Note
  String note = '';
  // Pick category
  PickedIconModel pickedCategory = PickedIconModel(icon: '', name: '', id: '') ;
  PickedIconModel pickedWallet = PickedIconModel(icon: '', name: '', id: '') ;

  void getDate(){
    // return 'Monday, 2022-02-02';
    chosenDateOccurTransaction = getCurrentDayMonthYear();
    nameOfTheDay= getNameOfDay(getCurrentDayMonthYear());
  }
  // Save transaction
  Future <void> saveTransaction() async {
    print(
        {
          'amount_of_money' : _amountController.text,
          'transaction_type_category_id' : pickedCategory.id,
          'occur_date' : chosenDateOccurTransaction,
          'money_account_id' : pickedWallet.id,
          'description' : note,
        }
    );
  }

  @override
  void initState() {

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dividerIndent = screenHeight * 0.094;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
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
                dynamic result = await context.push('${RoutesName.addingWorkSpacePath}/${RoutesName.selectWalletPath}');
                if(result != null){
                  pickedWallet = result;
                }
              },
              title: pickedWallet.name.isEmpty ? 'Tiền mặt' : pickedWallet.name,
              leading: pickedWallet.icon.isEmpty ?
                Image.asset('assets/another_icon/wallet-2.png', width: defaultLeadingPngListTileSize) :
                Image.asset(pickedWallet.icon, width: defaultLeadingPngListTileSize),
            ),
            MyDivider(indent: dividerIndent),
            //Pick amount
            CustomTextfield(
              amountController: _amountController,
              textInputType: TextInputType.number,
              prefixIcon: PrefixIconAmountTextfield(),
              fontSize: 40,
              hintText: '0',
              prefixIconPadding: const EdgeInsets.only(right: 11, left: 10),
            ),
            MyDivider(indent: dividerIndent),
            //Pick category
            MyListTitle(
              title: pickedCategory.name.isNotEmpty ? pickedCategory.name:  'Select category' ,
              titleTextStyle: const TextStyle(
                fontSize: extraBigger,
                color: colorTextLabel,
                fontWeight: FontWeight.w500
              ),
              callback: () async {
                dynamic result = await context.push<PickedIconModel>(
                  '${RoutesName.addingWorkSpacePath}/${RoutesName.pickCategoryPath}',
                    extra: pickedCategory.id// Send the picked categoryId
                );
                if(result != null){
                  setState(() {
                    pickedCategory = result as PickedIconModel;
                  });
                }
              },
              verticalContentPadding: 4,
              leading: FittedBox(
                child: Image.asset(
                  pickedCategory.icon.isNotEmpty ?
                  pickedCategory.icon: 'assets/another_icon/wallet-2.png',
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
                    '${RoutesName.addingWorkSpacePath}/${RoutesName.addNotePath}', extra: note);
                setState(() {
                  note = result;
                });
              },
              title: note.isNotEmpty ? note : 'Note',
              leading: SvgContainer(
                iconWidth: 30,
                iconPath: 'assets/svg/notes.svg'
              ),
              horizontalTitleGap: 18,
            ),
            MyDivider(indent: dividerIndent),
            //Pick date
            MyListTitle(
              callback: () {
                showDateOptionBottomSheet(context, (value){
                  setState(() {
                    chosenDateOccurTransaction = value;
                    nameOfTheDay= getNameOfDay(chosenDateOccurTransaction);
                  });
                });
              },
              title: '$nameOfTheDay, $chosenDateOccurTransaction',
              leading: SvgContainer(
                iconWidth: 28,
                iconPath: 'assets/svg/calendar.svg'
              ),
              horizontalTitleGap: 18,
            ),
            MyDivider(),
            const SizedBox(height: 20,),
            ExpandedArea(),
            const SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}

