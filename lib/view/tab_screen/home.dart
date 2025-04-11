// ignore_for_file: library_private_types_in_public_api, prefer_const_constructor
import 'package:fe_financial_manager/view/home_tab/widgets/chart_section.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/header.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/wallets_banner.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
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
      Provider.of<AppViewModel>(context, listen: false).getIconCategoriesApi();
      Provider.of<TransactionViewModel>(context, listen: false).getTransactionInRangeTime(
          {'from' : '2025-03-01', 'to' : '2025-04-11', 'money_account_id' : ''});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 6),
            //Header
            Header(),

            SizedBox(height: 12,),
            WalletBanner(),
            SizedBox(height: 12,),
            //Row chart
            ChartSection(),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
}




