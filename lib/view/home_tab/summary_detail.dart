import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/tab_bar_elements.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/summary_detail_tab.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widget/custom_back_navbar.dart';
class SummaryDetail extends StatefulWidget {
  const SummaryDetail({super.key});

  @override
  State<SummaryDetail> createState() => _SummaryDetailState();
}

class _SummaryDetailState extends State<SummaryDetail> with TickerProviderStateMixin {
  late final TabController _tabController;
  late int _selectedTab;

  @override
  void initState() {
    _selectedTab = 0;
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });

    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CustomBackNavbar(),
          title: const Text('Chi tiết'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tab bar
            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    TabBarElements(
                      tabController: _tabController,
                      selectedTab: _selectedTab,
                      index: 0,
                      title: 'Expense',
                    ),
                    TabBarElements(
                      tabController: _tabController,
                      selectedTab: _selectedTab,
                      index: 1,
                      title: 'Income',
                    ),
                  ],
                ),
              ),
            ),
            // Tab bar view
            Expanded(
              child: Consumer<TransactionViewModel>(
                builder: (context, value, child) {
                  Map<String, double> expense = value.expenseDataForPieChart;
                  Map<String, double> income = value.incomeDataForPieChart;

                  Map<PickedIconModel, dynamic> expenseTransactionForDetailSummary = value.expenseTransactionForDetailSummary;
                  Map<PickedIconModel, dynamic> incomeTransactionForDetailSummary = value.incomeTransactionForDetailSummary;

                  double totalExpense = double.parse(value.transactionForChart.data!['total_all_expense']);
                  double totalIncome = double.parse(value.transactionForChart.data!['total_all_income']);

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      SummaryDetailTab(
                        tabType: 'Total Expense',
                        chartData: expense,
                        transactionData: expenseTransactionForDetailSummary,
                        totalMoney: totalExpense,
                      ),
                      SummaryDetailTab(
                        tabType: 'Total Income',
                        chartData: income,
                        transactionData: incomeTransactionForDetailSummary,
                        totalMoney: totalIncome,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        )

    );
  }
}
