import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/utils/get_initial_wallet.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/budgets/widgets/range_time_bottom_sheets.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/custom_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_float_action_button.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/prefix_icon_amount_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view/common_widget/switch_row.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_model/wallet_view_model.dart';
class CreateUpdateBudget extends StatefulWidget {
  const CreateUpdateBudget({super.key, this.budgets});
  final Map<String, dynamic> ?  budgets;

  @override
  State<CreateUpdateBudget> createState() => _CreateUpdateBudgetState();
}

class _CreateUpdateBudgetState extends State<CreateUpdateBudget> {
  final TextEditingController _amountController = TextEditingController();
  bool isRepeatBudget = false;
  PickedIconModel pickedCategory = PickedIconModel(icon: '', name: '', id: '') ;
  PickedIconModel pickedWallet = PickedIconModel(icon: '', name: '', id: '') ;

  void onItemCategoryTap(PickedIconModel value){
    setState(() {
      pickedCategory = value;
    });
    context.pop();
  }

  @override
  void initState() {
    if(widget.budgets == null){
      final AppViewModel appViewModel = Provider.of<AppViewModel>(context, listen: false);
      final List<dynamic> listCategoriesData = appViewModel.iconCategoriesData.data?.categoriesIconListMap['expense'] ?? [];

      final WalletViewModel walletViewModel = Provider.of<WalletViewModel>(context, listen: false);
      final List<dynamic> listWalletData = walletViewModel.allWalletData.data ?? [];

      getInitialData((data){
        setState(() {
          pickedCategory = data;
        });
      }, listCategoriesData, context);

      getInitialData((data){
        setState(() {
          pickedWallet = data;
        });
      }, listWalletData, context);
    }else {

    }
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
    final double dividerIndent = screenHeight * 0.094;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.budgets == null ? 'Add Budget': 'Update Budget'),
        leading: CustomBackNavbar(),
        actions: [
          Visibility(
            visible: widget.budgets != null,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgContainer(
                iconWidth: 22,
                iconPath: Assets.svgTrash,
                myIconColor: emergencyColor,
                callback: (){

                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: MyFloatActionButton(callback: () {  },),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            MyListTitle(
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
            //Pick amount
            CustomTextfield(
              amountController: _amountController,
              textInputType: TextInputType.number,
              prefixIcon: PrefixIconAmountTextfield(),
              fontSize: extraBigger,
              hintText: '0',
              prefixIconPadding: const EdgeInsets.only(right: 11, left: 10),
              verticalPadding: 10,
            ),
            MyDivider(indent: dividerIndent),
            MyListTitle(
              callback: () {
                showRangeTimeOptionBottomSheet(context, (){

                });
              },
              title: 'This month (01/03 - 31/03)',
              leading: SvgContainer(
                  iconWidth: 28,
                  iconPath: Assets.svgCalendar
              ),
              horizontalTitleGap: 18,
            ),
            MyDivider(indent: dividerIndent),
            MyListTitle(
              callback: () async{
                dynamic result = await context.push(FinalRoutes.selectWalletPath);
                if(result != null){
                  pickedWallet = result;
                }
              },
              title: pickedWallet.name.isEmpty ? 'Choose Wallet' : pickedWallet.name,
              leading: pickedWallet.icon.isEmpty ?
              Image.asset('assets/another_icon/wallet-2.png', width: defaultLeadingPngListTileSize) :
              Image.asset(pickedWallet.icon, width: defaultLeadingPngListTileSize),
            ),
            const SizedBox(height: 30,),
            SwitchRow(
              flag: isRepeatBudget,
              callback: (value){
                setState(() {
                  isRepeatBudget = value;
                });
              },
              text: 'Repeat this budget'
            )
          ],
        ),
      ),
    );
  }
}
