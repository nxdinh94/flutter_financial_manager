import 'package:diacritic/diacritic.dart';
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
import 'package:fe_financial_manager/view/wallets/widgets/external_bank_logo_circle.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
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
  final TextEditingController _creditLimitationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final WalletViewModel _walletViewModel = WalletViewModel();
  bool isIncludeFromReport = true;
  late PickedIconModel pickedWalletType;

  PickedIconModel pickedBank = PickedIconModel(icon: '', name: '', id: '');
  late Map<String, dynamic> initialSubmitData;
  Map<String, dynamic> submitData = {};
  @override
  void initState() {
    super.initState(); // Call super first
    final walletViewModel = Provider.of<WalletViewModel>(context, listen: false);

    if (walletViewModel.iconWalletTypeData.data != null) {
      WalletTypeIconModel defaultWalletType = walletViewModel.iconWalletTypeData.data[0];
      pickedWalletType = PickedIconModel(
        icon: defaultWalletType.icon,
        name: defaultWalletType.name,
        id: defaultWalletType.id,
      );
    }else {
      pickedWalletType = PickedIconModel(icon: '', name: '', id: '');
    }
    initialSubmitData = {
      'account_balance' : '',
      'name' : '',
      'description' : '',
      'money_account_type_id' : '',
      'save_to_report' : true,
    };
    submitData = initialSubmitData;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _creditLimitationController.dispose();
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
      floatingActionButton: MyFloatActionButton(callback: ()async{

        submitData['account_balance'] = _amountController.text;
        submitData['name'] = _nameController.text;
        submitData['description'] = _noteController.text;
        submitData['money_account_type_id']  = pickedWalletType.id;
        submitData['save_to_report'] = isIncludeFromReport;
        if(removeDiacritics(pickedWalletType.name) == 'Vi tin dung'){
          submitData['credit_limit'] = _creditLimitationController.text;
        }
        print(submitData);

        // await _walletViewModel.createWallet(initialSubmitData, context);

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

            Visibility(
              visible: removeDiacritics(pickedWalletType.name) == 'Vi tin dung',
              child: MyDivider()
            ),
            //Credit -limitation
            Visibility(
              visible: removeDiacritics(pickedWalletType.name) == 'Vi tin dung',
              child: CustomTextfield(
                amountController: _creditLimitationController,
                hideLegend: false,
                legend: Text('Credit limitation', style: Theme.of(context).textTheme.bodyLarge,),
                textInputType: TextInputType.number,
                prefixIcon: PrefixIconAmountTextfield(width: 40,),
                fontSize: 40,
                hintText: '0',
                prefixIconPadding: const EdgeInsets.only(right: 12, left: 10),
                onChange: (e){
                  setState(() {
                    submitData['credit_limit'] = e;
                  });
                },
              ),
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

            //Wallet type
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
                    if(removeDiacritics(pickedWalletType.name) == 'Tai khoan ngan hang'){
                      //reset submitData
                      submitData.clear();
                      submitData = initialSubmitData;
                      final Map<String, dynamic> bankType = {'bank_type' : pickedBank.id.isNotEmpty ? double.parse(pickedBank.id) : ''};
                      submitData.addAll(bankType);
                    }else if(removeDiacritics(pickedWalletType.name) == 'Vi tin dung'){
                      submitData.clear();
                      submitData = initialSubmitData;
                      final Map<String, dynamic> bankTypeAndCreditLimit = {
                        'bank_type' : pickedBank.id.isNotEmpty ? double.parse(pickedBank.id) : '',
                        'credit_limit' : ''
                      };
                      submitData.addAll(bankTypeAndCreditLimit);
                    }else {
                      // Invest wallet & another wallet
                      submitData.clear();
                      submitData = initialSubmitData;
                    }
                  });
                }
              },
            ),
            MyDivider(indent: dividerIndent,),
            //Bank
            Visibility(
              visible:
                removeDiacritics(pickedWalletType.name) == 'Tai khoan ngan hang' ||
                removeDiacritics(pickedWalletType.name) == 'Vi tin dung',
              child: MyListTitle(
                leading: pickedBank.icon == '' ?
                  SvgContainer(iconPath: 'assets/svg/bank.svg', iconWidth: 52, containerSize: 40) :
                  ExternalBankLogoCircle(logo: pickedBank.icon,),
                title: pickedBank.name == '' ? 'Bank' : pickedBank.name,
                horizontalTitleGap: 10,
                leftContentPadding: 10,
                callback: ()async{
                  dynamic result = await context.push(
                    '${RoutesName.addWalletsPath}/${RoutesName.pickExternalBankPath}'
                  );
                  if(result != null){
                    setState(() {
                      pickedBank = result as PickedIconModel;
                      submitData['bank_type'] = double.parse(pickedBank.id);
                    });
                  }
                },
              ),
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
                text: 'Include from report',
                callback: (value){
                  setState(() {
                    isIncludeFromReport = value;
                  });
                },
                flag: isIncludeFromReport,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

