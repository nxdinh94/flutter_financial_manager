// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/wallets_banner.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletViewModel>(context, listen: false).getIconsWalletType();
      Provider.of<WalletViewModel>(context, listen: false).getAllWallet();
      Provider.of<WalletViewModel>(context, listen: false).getExternalBank();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: defaultHalfPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MoneyVnd(fontSize: 24, amount: 999999999, iconColor: black,),
                      const SizedBox(width: 12),
                      SvgContainer(iconWidth: 22, iconPath: 'assets/svg/eye.svg', myIconColor: black,),
                    ],
                  ),
                  Row(
                    children: [
                      SvgContainer(
                        iconWidth: 22, myIconColor: black,
                        iconPath: 'assets/svg/magnifying-glass.svg',
                      ),
                      const SizedBox(width: 24),
                      SvgContainer(
                        iconWidth: 22, myIconColor: Colors.black,
                        iconPath: 'assets/svg/bell.svg'
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text('Total balance', style: Theme.of(context).textTheme.labelLarge,),
                  SvgContainer(iconWidth: 14, iconPath: 'assets/svg/question-mark-circle.svg')
                ],
              ),
              const SizedBox(height: 12,),
              WalletBanner()
            ],
          ),
        ),
      )
    );
  }
}

