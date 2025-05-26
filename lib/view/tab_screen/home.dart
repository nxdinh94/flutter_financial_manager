import 'package:fe_financial_manager/model/params_get_transaction_in_range_time.dart';
import 'package:fe_financial_manager/utils/common_range_time.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/chart_section.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/header.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/recent_transactions.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/budget_view_model.dart';
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
  get dashBorder => null;

  @override
  void initState() {

    List<String> thisMonth = getThisMonth().split('/');
    String beginOfMonth = thisMonth[0];
    String endOfMonth = thisMonth[1];

    ParamsGetTransactionInRangeTime defaultRangeTime = ParamsGetTransactionInRangeTime(
      from: beginOfMonth,
      to: endOfMonth,
      moneyAccountId: '',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Make sure that getIconCategoriesApi is invoked first
      await Provider.of<AppViewModel>(context, listen: false).getUserPersonalizationStatus(context);
      await Provider.of<AppViewModel>(context, listen: false).getIconCategoriesApi();
      Provider.of<TransactionViewModel>(context, listen: false).setParamsGetTransactionChartInRangeTime(defaultRangeTime);
      await Provider.of<WalletViewModel>(context, listen: false).getIconsWalletType();
      await Provider.of<WalletViewModel>(context, listen: false).getAllWallet();
      await Provider.of<WalletViewModel>(context, listen: false).getExternalBank();
      await Provider.of<TransactionViewModel>(context, listen: false).getTransactionInRangeTime(defaultRangeTime);
      // Default range time is current month
      await Provider.of<TransactionViewModel>(context, listen: false).getTransactionForChart(defaultRangeTime, context);
      await Provider.of<BudgetViewModel>(context, listen: false).getAllBudgets(context);
      await Provider.of<AppViewModel>(context, listen: false).getUserPersonalizationDataForChatBot(context);
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
            //Row chart
            ChartSection(),
            SizedBox(height: 20,),
            RecentTransactions(),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
}





