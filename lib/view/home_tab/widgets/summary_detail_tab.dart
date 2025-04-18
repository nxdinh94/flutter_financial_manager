import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/view/common_widget/empty_value_screen.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/my_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common_widget/progress_bar.dart';
class SummaryDetailTab extends StatefulWidget {
  const SummaryDetailTab({
    super.key,
    required this.tabType,
    required this.chartData,
    required this.transactionData,
    required this.totalMoney,
  });
  final String tabType;
  final Map<String, double> chartData;
  final Map<PickedIconModel, dynamic> transactionData;
  final double totalMoney;
  @override
  State<SummaryDetailTab> createState() => _SummaryDetailTabState();
}

class _SummaryDetailTabState extends State<SummaryDetailTab> {
  int countTransaction = -1;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    countTransaction = -1;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: primaryColor,
            padding: defaultHalfPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.tabType, style: Theme.of(context).textTheme.titleLarge),
                MoneyVnd(fontSize: big, amount: widget.totalMoney)
              ],
            ),
          ),
          const SizedBox(height: 12),
          widget.chartData.isEmpty ?
          const EmptyValueScreen(title: 'No data', isAccountPage: false, iconSize: 60,) :
          Container(
            height: 240,
            color: primaryColor,
            alignment: Alignment.center,
            child: MyPieChart(
              dataMap: widget.chartData,
              height: 200,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: widget.transactionData.entries.map((e){
              countTransaction++;
              PickedIconModel parent = e.key;
              List<TransactionHistoryModel> value = e.value;
              double totalMoney = value.fold(0, (sum, item) => sum + double.parse(item.amountOfMoney));

              double percentage = totalMoney/widget.totalMoney;
              return Container(
                padding: horizontalHalfPadding,
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  children: [
                    Column(
                      children: [
                        MyListTitle(
                          callback: () {
                            context.push(FinalRoutes.groupTransactionDetailPath, extra: {
                              'parentName': parent.name,
                              'transactionType': widget.tabType,
                            });
                          },
                          leading: Image.asset(parent.icon, width: 24),
                          title: parent.name,
                          horizontalTitleGap: 4,
                          leftContentPadding: 0,
                          rightContentPadding: 0,
                          trailing: RichText(
                            text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: MoneyVnd(
                                      amount: totalMoney,
                                      fontSize: normal,
                                    ),
                                  ),
                                  TextSpan(
                                      text: '(${(percentage * 100).toStringAsFixed(2)}% )',
                                      style: const TextStyle(
                                          fontSize: small,
                                          color: colorTextLabel
                                      )
                                  ),
                                  const WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(Icons.keyboard_arrow_right, color: iconColor, size: 23,
                                  ))
                                ]
                            ),
                          ),
                        ),
                        MyProgressBar(
                          percentage: percentage,
                          color: pieChartColorList[countTransaction],
                          lineHeight: 7,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                    const Divider()
                  ],
                ),
              );
            }).toList()
          )
        ],
      )
    );
  }
}
