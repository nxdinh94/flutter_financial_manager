import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/wallet_type_icon_model.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
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

class AddWallets extends StatefulWidget {
  const AddWallets({super.key});
  @override
  State<AddWallets> createState() => _AddWalletsState();
}

class _AddWalletsState extends State<AddWallets> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool isExcludeFromReport = false;

  late PickedIconModel pickedWalletType;


  @override
  void initState() {
    WalletTypeIconModel defaultWalletType =  context.read<AppViewModel>().iconWalletTypeData.data[0];
    pickedWalletType = PickedIconModel(
      icon: defaultWalletType.icon,
      name: defaultWalletType.name,
      id: defaultWalletType.id
    );
    super.initState();
  }
  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dividerIndent = screenHeight * 0.079;

  return Scaffold(
      appBar: AppBar(
        title: const Text('Add Wallets'),
        leading: CustomBackNavbar(),
      ),
      floatingActionButton: MyFloatActionButton(callback: (){
        print(
          {
            'amount' : _amountController.text,
            'name' : _nameController.text,
            'note' : _noteController.text,
            'isExcludeFromReport' : isExcludeFromReport,
            'walletType' : pickedWalletType.id
          }
        );
      }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextfield(
              amountController: _amountController,
              hideLegend: false,
              legend: Text('Initials balance', style: Theme.of(context).textTheme.bodyLarge,),
              textInputType: TextInputType.number,
              prefixIcon: PrefixIconAmountTextfield(width: 40,),
              fontSize: 40,
              hintText: '0',
              prefixIconPadding: const EdgeInsets.only(right: 12, left: 10),
            ),
            MyDivider(indent: dividerIndent,),

            const SizedBox(height: 12,),
            CustomTextfield(
              amountController: _nameController,
              textInputType: TextInputType.text,
              prefixIcon: Image.asset('assets/another_icon/wallet-2.png', width: defaultLeadingPngListTileSize),
              fontSize: big,
              hintText: 'Wallet name',
              verticalPadding: 6,
              prefixIconPadding: const EdgeInsets.only(right: 12, left: 10),
            ),
            MyDivider(indent: dividerIndent,),
            MyListTitle(
              leading: pickedWalletType.icon == '' ?
                Image.asset('assets/account_type/bank.png', width: defaultLeadingPngListTileSize) :
                Image.asset(pickedWalletType.icon, width: defaultLeadingPngListTileSize),
              title: pickedWalletType.name == '' ? 'Tiền mặt' : pickedWalletType.name,
              horizontalTitleGap: 12,
              leftContentPadding: 10,
              callback: ()async{
                dynamic result = await context.push(
                  '${RoutesName.addWalletsPath}/${RoutesName.pickWalletTypePath}',
                  extra: pickedWalletType.id
                );
                if(result != null){
                  setState(() {
                    pickedWalletType = result as PickedIconModel;
                  });
                }
              },
            ),
            MyDivider(indent: dividerIndent,),
            CustomTextfield(
              amountController: _noteController,
              textInputType: TextInputType.text,
              prefixIcon: SvgContainer(
                iconWidth: 27,
                iconPath: 'assets/svg/notes.svg',
                containerSize: 38,
              ),
              fontSize: big,
              hintText: 'Note',
              verticalPadding: 6,
              prefixIconPadding: const EdgeInsets.only(right: 12, left: 10),
            ),
            MyDivider(indent: dividerIndent,),

            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: horizontalHalfPadding,
              child: SwitchRow(
                text: 'Exclude from report',
                callback: (value){
                  setState(() {
                    isExcludeFromReport = value;
                  });
                },
                flag: isExcludeFromReport,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
