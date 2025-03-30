import 'package:diacritic/diacritic.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/model/wallet_type_icon_model.dart';
import 'package:fe_financial_manager/utils/cleaned_number.dart';
import 'package:fe_financial_manager/utils/get_initial_wallet.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/utils/utils.dart';
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
  const AddWallets({super.key, this.walletToUpdate});
  final WalletModel ? walletToUpdate;
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
  Map<String, dynamic> dataToSubmit = {};

  void updateRequiredAttributeForDataToSubmit(){
    dataToSubmit['account_balance'] = cleanedNumber(_amountController.text);
    dataToSubmit['name'] = _nameController.text;
    dataToSubmit['description'] = _noteController.text;
    dataToSubmit['money_account_type_id']  = pickedWalletType.id;
    dataToSubmit['save_to_report'] = isIncludeFromReport;
    if(removeDiacritics(pickedWalletType.name) == 'Vi tin dung'){
      dataToSubmit['credit_limit'] = cleanedNumber(_creditLimitationController.text);
    }
  }
  void validateDataToSubmit (){
    if(_amountController.text.isEmpty && _nameController.text.isEmpty){
      Utils.flushBarErrorMessage('Initial money or name of wallet cannot be empty', context);
      return;
    }
    if(removeDiacritics(pickedWalletType.name) == 'Vi tin dung'
        || removeDiacritics(pickedWalletType.name) == 'Tai khoan ngan hang'){
      if(dataToSubmit['bank_type'].toString().isEmpty){
        Utils.flushBarErrorMessage('Bank is required', context);
        return;
      }
    }
    if(removeDiacritics(pickedWalletType.name) == 'Vi tin dung'){
      if(_creditLimitationController.text.isEmpty){
        Utils.flushBarErrorMessage('Credit limitation is required', context);
        return;
      }
    }
  }
  void onItemCategoryTap(PickedIconModel value){
    setState(() {
      pickedWalletType = value;
      //reset submitData
      dataToSubmit.clear();
      if(removeDiacritics(pickedWalletType.name) == 'Tai khoan ngan hang'){
        final Map<String, dynamic> bankType = {'bank_type' : pickedBank.id.isNotEmpty ? double.parse(pickedBank.id) : ''};
        dataToSubmit.addAll(bankType);
      }else if(removeDiacritics(pickedWalletType.name) == 'Vi tin dung'){
        final Map<String, dynamic> bankTypeAndCreditLimit = {
          'bank_type' : pickedBank.id.isNotEmpty ? double.parse(pickedBank.id) : '',
          'credit_limit' : ''
        };
        dataToSubmit.addAll(bankTypeAndCreditLimit);
      }
    });
    context.pop();
  }
  @override
  void initState() {
    super.initState(); // Call super first
    if(widget.walletToUpdate == null){
      final WalletViewModel walletViewModel = Provider.of<WalletViewModel>(context, listen: false);
      List<WalletTypeIconModel> listData = walletViewModel.iconWalletTypeData.data ?? [];
      getInitialData<WalletTypeIconModel>((data){
        setState(() {
          pickedWalletType = data;
        });
      },listData, context);
    }else{
      pickedWalletType = PickedIconModel(
        icon: widget.walletToUpdate!.icon,
        name: widget.walletToUpdate!.name,
        id: widget.walletToUpdate!.id
      );
      _amountController.text = widget.walletToUpdate!.accountBalance;
      _nameController.text = widget.walletToUpdate!.name;
      // _noteController.text = widget.walletToUpdate!.;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _creditLimitationController.dispose();
    _noteController.dispose();
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
        updateRequiredAttributeForDataToSubmit();
        validateDataToSubmit();
        print(dataToSubmit);

        await _walletViewModel.createWallet(dataToSubmit, context);

      }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextfield(
              controller: _amountController,
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
                controller: _creditLimitationController,
                hideLegend: false,
                legend: Text('Credit limitation', style: Theme.of(context).textTheme.bodyLarge,),
                textInputType: TextInputType.number,
                prefixIcon: PrefixIconAmountTextfield(width: 40,),
                fontSize: 40,
                hintText: '0',
                prefixIconPadding: const EdgeInsets.only(right: 12, left: 10),
                onChange: (e){
                  setState(() {
                    dataToSubmit['credit_limit'] = e;
                  });
                },
              ),
            ),
            MyDivider(indent: dividerIndent,),
            const SizedBox(height: 12,),
            CustomTextfield(
              controller: _nameController,
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
              title: pickedWalletType.name == '' ? 'Choose Wallet' : pickedWalletType.name,
              horizontalTitleGap: 12,
              leftContentPadding: 10,
              isShowAnimate: false,
              callback: (){
                context.push(
                  FinalRoutes.pickWalletTypePath,
                  extra: {
                    'pickedWalletType': pickedWalletType,
                    'onTap' : onItemCategoryTap
                  }
                );
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
                  SvgContainer(
                    iconPath: Assets.svgBank,
                    iconWidth: 52, containerSize: 40) :
                  ExternalBankLogoCircle(logo: pickedBank.icon,),
                title: pickedBank.name == '' ? 'Bank' : pickedBank.name,
                horizontalTitleGap: 10,
                leftContentPadding: 10,
                callback: ()async{
                  dynamic result = await context.push(FinalRoutes.pickExternalBankPath);
                  if(result != null){
                    setState(() {
                      pickedBank = result as PickedIconModel;
                      dataToSubmit['bank_type'] = double.parse(pickedBank.id);
                    });
                  }
                },
              ),
            ),
            MyDivider(indent: dividerIndent,),
            CustomTextfield(
              controller: _noteController,
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

            SwitchRow(
              text: 'Include from report',
              callback: (value){
                setState(() {
                  isIncludeFromReport = value;
                });
              },
              flag: isIncludeFromReport,
            ),
          ],
        ),
      ),
    );
  }
}

