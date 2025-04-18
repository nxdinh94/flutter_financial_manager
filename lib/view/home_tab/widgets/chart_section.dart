import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/loading_animation.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/column_chart_label.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/my_column_chart.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/my_pie_chart.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/rangeTimeChartHomePage.dart';
import '../../../model/ParamsGetTransactionInRangeTime.dart';
class ChartSection extends StatefulWidget {
  const ChartSection({
    super.key,
  });

  @override
  State<ChartSection> createState() => _ChartSectionState();
}

class _ChartSectionState extends State<ChartSection> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String defaultRangeTimeChartHomePage = rangeTimeHomePageChart[2]['value'];

    return Container(
      padding: defaultHalfPadding,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Financial Summary', style: Theme.of(context).textTheme.titleLarge,),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              DropdownButton<String>(
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down,),
                iconSize: 26,
                dropdownColor: primaryColor,
                elevation: 0,
                isDense: true,
                value: defaultRangeTimeChartHomePage,
                onChanged: (String? time) async {
                  String from = time!.split('/')[0];
                  String to = time.split('/')[1];
                  // Meaning of ~ is all the time
                  if(from == '~' && to == '~'){
                    await Provider.of<TransactionViewModel>(context, listen: false).getTransactionForChart(
                        ParamsGetTransactionInRangeTime(from : '', to : '', moneyAccountId : ''), context);
                  }else {
                    await Provider.of<TransactionViewModel>(context, listen: false).getTransactionForChart(
                        ParamsGetTransactionInRangeTime(from: from, to: to, moneyAccountId: ''), context);
                  }
                },
                style: const TextStyle(color: Colors.blue),
                selectedItemBuilder: (BuildContext context) {
                  return rangeTimeHomePageChart.map((Map<String, dynamic> value) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value['title'],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }).toList();
                },
                items: rangeTimeHomePageChart.map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
                  return DropdownMenuItem<String>(
                    value: '${value['value']}',
                    child: Text(value['title'],style: Theme.of(context).textTheme.bodyLarge),
                  );
                }).toList(),
              ),
            ],
          ),
          Consumer<TransactionViewModel>(
            builder: (context, value, child) {
              switch (value.transactionForChart.status) {
                case Status.LOADING:
                  return const LoadingAnimation(containerHeight: 200, iconSize: 60,);
                case Status.COMPLETED:
                  dynamic transaction = value.transactionForChart.data?['transactions_by_date'];
                  double expense = double.parse(value.transactionForChart.data!['total_all_expense']);
                  double income = double.parse(value.transactionForChart.data!['total_all_income']);
                  double balance = income - expense;
                  Map<String, double> expenseDataForPieChart = value.expenseDataForPieChart;
                  if(transaction.isEmpty){
                    return  Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        'You have no record yet',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        context.push(FinalRoutes.summaryDetailPath);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 4,
                                child: SizedBox(
                                  height: 160,
                                  child: MyColumnChart(
                                    data: [
                                      ColumnChartModel(1, income, secondaryColor),
                                      ColumnChartModel(2, expense, expenseColumnChartColor),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 7,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ColumnChartLabel(
                                        color: secondaryColor,
                                        label: 'Income',
                                        amount: income,
                                      ),
                                      ColumnChartLabel(
                                        color: expenseColumnChartColor,
                                        label: 'Expense',
                                        amount: expense,
                                      ),
                                      MyDivider(),
                                      const SizedBox(height: 12,),
                                      MoneyVnd(fontSize: big, amount: balance)
                                    ],
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: 48),
                          // Only show if there are expenses
                          Visibility(
                            visible: expenseDataForPieChart.isNotEmpty,
                            child: MyPieChart(dataMap: expenseDataForPieChart)
                          ),
                        ],
                      ),
                    ),
                  );
                case Status.ERROR:
                  return const Center(child: Text('Error'));
                default :
                  return const SizedBox.shrink();
              }
            }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Note history',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: secondaryColor),
                  children: const [
                    WidgetSpan(child: Icon(Icons.arrow_forward_ios_rounded, size: 15, color: secondaryColor)),
                  ]
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
