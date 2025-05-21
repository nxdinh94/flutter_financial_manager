import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/utils/format_number.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/custom_stack_three_images.dart';
import 'package:fe_financial_manager/view/common_widget/custom_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_float_action_button.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/prefix_icon_amount_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/common_range_time.dart';
import '../../utils/utils.dart';
import '../../view_model/budget_view_model.dart';
import '../../view_model/wallet_view_model.dart';
class CreateUpdateBudget extends StatefulWidget {
  const CreateUpdateBudget({super.key, this.budgets});
  final Map<String, dynamic> ?  budgets;

  @override
  State<CreateUpdateBudget> createState() => _CreateUpdateBudgetState();
}

class _CreateUpdateBudgetState extends State<CreateUpdateBudget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String thisMonth = getThisMonth();
  String startDate = '';
  String endDate = '';

  void onItemCategoryTap(PickedIconModel value){
    setState(() {
    });
    context.pop();
  }
  List <String> listOfIdOfExpenseCategory = [];
  List <String> listOfIdOfWallet = [];

  @override
  void initState() {
    final AppViewModel appViewModel = Provider.of<AppViewModel>(context, listen: false);
    final WalletViewModel walletViewModel = Provider.of<WalletViewModel>(context, listen: false);
    listOfIdOfExpenseCategory = appViewModel.listIdOfExpenseCategory;
    listOfIdOfWallet = walletViewModel.listOfIdOfWallet;

    if(widget.budgets == null){
      startDate = thisMonth.split('/')[0];
      endDate = thisMonth.split('/')[1];
    }else {
      _nameController.text = widget.budgets!['budget']['name'];
      _amountController.text = FormatNumber.format(widget.budgets!['budget']['amount_of_money'].toString());
      startDate = DateTimeHelper.convertDateTimeToString(DateTime.parse(widget.budgets!['budget']['start_date']));
      endDate = DateTimeHelper.convertDateTimeToString(DateTime.parse(widget.budgets!['budget']['end_date']));}
  super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dividerIndent = screenHeight * 0.093;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.budgets == null ? 'Add Budget': 'Update Budget'),
        leading: const CustomBackNavbar(),
        actions: [
          Visibility(
            visible: widget.budgets != null,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgContainer(
                iconWidth: 22,
                iconPath: Assets.svgTrash,
                myIconColor: emergencyColor,
                callback: ()async{
                  await context.read<BudgetViewModel>().deleteBudget(widget.budgets!['budget']['id'], context);
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: MyFloatActionButton(
        callback: () async{
          Map<String, dynamic> dataToSubmit = {
            "name" : _nameController.text,
            "amount_of_money" : FormatNumber.cleanedNumber(_amountController.text),
            "start_date": startDate,
            "end_date": endDate,
            "money_accounts" : listOfIdOfWallet,
            "transaction_type_categories" : listOfIdOfExpenseCategory,
          };
          if(_nameController.text.isEmpty || _amountController.text.isEmpty){
            Utils.flushBarErrorMessage('Please fill all the fields', context);
            return;
          }
          if(widget.budgets == null){
            await context.read<BudgetViewModel>().createBudget(dataToSubmit, context);
          }else{
            dataToSubmit['id'] = widget.budgets!['budget']['id'];
            await context.read<BudgetViewModel>().updateBudget(dataToSubmit, context);
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),

            //name
            CustomTextfield(
              controller: _nameController,
              prefixIcon: SvgContainer(iconPath: Assets.svgWallet, iconWidth: 38, containerSize: 50),
              fontSize: big,
              hintText: 'Name of budget',
              prefixIconPadding: const EdgeInsets.only(right: 11, left: 10),

            ),
            MyDivider(indent: dividerIndent),//Pick amount
            CustomTextfield(
              controller: _amountController,
              textInputType: TextInputType.number,
              prefixIcon: const PrefixIconAmountTextfield(),
              fontSize: extraBigger,
              hintText: '0',
              prefixIconPadding: const EdgeInsets.only(right: 11, left: 10),
              verticalPadding: 10,
            ),
            MyDivider(indent: dividerIndent),
            MyListTitle(
              title: "All categories",
              callback: () {

              },
              leftContentPadding: 0,
              horizontalTitleGap: 0,
              verticalContentPadding: 4,
              leading: const StackThreeCircleImages(
                  imageOne: 'assets/icon_category/spending_money_icon/anUong/breakfast.png',
                  imageTwo: 'assets/icon_category/spending_money_icon/conCai/book.png',
                  imageThree: 'assets/icon_category/spending_money_icon/diLai/gas-pump.png'
              ),
            ),
            MyDivider(indent: dividerIndent),
            MyListTitle(
              callback: () async{

              },
              title: "All of wallets",
              leading: Image.asset('assets/another_icon/wallet.png', width: 30,),
            ),
            MyDivider(indent: dividerIndent),
            MyListTitle(
              callback: ()async{
                String result = await DateTimeHelper.showDatePicker(context);
                setState(() {
                  startDate = DateTimeHelper.convertDateTimeToString(DateTime.parse(result));
                });
              },
              title: 'Start date',
              titleTextStyle: Theme.of(context).textTheme.labelSmall!,
              subTitle: Text(startDate, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: big),),
              leading: SvgContainer(iconWidth: 28, iconPath: Assets.svgCalendar),
            ),
            MyListTitle(
              callback: ()async{
                String result = await DateTimeHelper.showDatePicker(context);
                setState(() {
                  endDate = DateTimeHelper.convertDateTimeToString(DateTime.parse(result));
                });
              },
              title: 'End date',
              titleTextStyle: Theme.of(context).textTheme.labelSmall!,
              subTitle: Text(endDate, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: big),),
              leading: SvgContainer(iconWidth: 28, iconPath: Assets.svgCalendar),
            ),


            // SwitchRow(
            //   flag: isRepeatBudget,
            //   callback: (value){
            //     setState(() {
            //       isRepeatBudget = value;
            //     });
            //   },
            //   text: 'Repeat this budget'
            // )
          ],
        ),
      ),
    );
  }
}
