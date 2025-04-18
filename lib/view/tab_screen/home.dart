// ignore_for_file: library_private_types_in_public_api, prefer_const_constructor
import 'package:fe_financial_manager/model/ParamsGetTransactionInRangeTime.dart';
import 'package:fe_financial_manager/utils/rangeTimeChartHomePage.dart';
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

    List<String> thisMonth = getThisMonth().split('/');
    String beginOfMonth = thisMonth[0];
    String endOfMonth = thisMonth[1];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Make sure that getIconCategoriesApi is invoked first
      Provider.of<AppViewModel>(context, listen: false).getIconCategoriesApi();
      Provider.of<WalletViewModel>(context, listen: false).getIconsWalletType();
              Provider.of<WalletViewModel>(context, listen: false).getAllWallet();
          Provider.of<WalletViewModel>(context, listen: false).getExternalBank();
      Provider.of<TransactionViewModel>(context, listen: false).getTransactionInRangeTime(
          ParamsGetTransactionInRangeTime(from : '', to : '', moneyAccountId : ''));
      // Default range time is current month
      Provider.of<TransactionViewModel>(context, listen: false).getTransactionForChart(
          ParamsGetTransactionInRangeTime(from : beginOfMonth, to : endOfMonth, moneyAccountId : ''), context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      key: ValueKey('homeTab'),
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




