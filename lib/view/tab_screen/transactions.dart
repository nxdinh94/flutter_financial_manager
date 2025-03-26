import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/data_sample.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/transactions/widgets/right_arrow_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';

import '../common_widget/dash_line_painter/dash_line_painter.dart';
import '../common_widget/loading_animation.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  String selectedTimeToShow = '';

  @override
  void initState() {
    selectedTimeToShow = 'All';
    // selectedTimeToShow = rangeTimeForExpenseRecord.first['title'];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const Border dashBorder = DashedBorder(
      dashLength: 5, left: BorderSide(color: dividerColor, width: 1),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: ()async{
                // Map<String, dynamic> result = await context.push(
                //     '${RoutesName.homePath}/'
                //         '${CustomNavigationHelper.selectTimeShowExpenseRecordPath}') as Map<String, dynamic>;
                // if(!context.mounted){return;}
                // if(result.isNotEmpty){
                //   setState(() {
                //       selectedTimeToShow  = result['title'];
                //   });
                // await Provider.of<UserProvider>(context, listen: false)
                //     .getAllExpenseRecordForNoteHistoryProvider(result['value']);
                // }
              },
              child: Container(
                color: primaryColor,
                padding: defaultHalfPadding,
                child: Center(
                    child: RightArrowRichText(
                        text: selectedTimeToShow, color: secondaryColor, fontWeight: FontWeight.w500
                    )
                ),
              ),
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, value, child) {
                // Map<String, dynamic> data = value.expenseRecordDataForNoteHistory;
                Map<String, dynamic> data = dataForTransactionHistory;
                String totalRevenueMoney = '0';
                String totalSpendingMoney = '0';
                if(data.isNotEmpty){
                  totalRevenueMoney = data['response_revenue_money'][r'$numberDecimal'];
                  totalSpendingMoney = data['response_spending_money'][r'$numberDecimal'];
                }
                // print(data);
                return Container(
                  color: primaryColor,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: defaultHalfPadding,
                            child: TotalRevenueOrSpendingItem(
                              title: 'Tổng thu',
                              amountOfMoney: totalRevenueMoney,
                              foreground: secondaryColor,
                            ),
                          ),
                        ),
                        const VerticalDivider(thickness: 1, color: dividerColor),
                        Expanded(
                          child: Padding(
                            padding: defaultHalfPadding,
                            child: TotalRevenueOrSpendingItem(
                              title: 'Tổng chi',
                              amountOfMoney: totalSpendingMoney,
                              foreground: emergencyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, value, child) {
                // Map<String, dynamic> data = value.expenseRecordDataForNoteHistory;
                Map<String, dynamic> data = dataForTransactionHistory;
                List<dynamic> records = data['response_expense_record'] ?? [];
                // if(value.isLoadingExpenseRecordDataForNoteHistory){
                //   return const Center(
                //     child: LoadingAnimation(
                //       iconSize: 80,
                //       containerHeight: 500,
                //     ),
                //   );
                // }
                if(records.isEmpty){
                  return const Center(
                    child: Text('No data', style: TextStyle(color: colorTextLabel, fontSize: normal)),
                  );
                }
                return BodyOfPage(records: records, dashBorder: dashBorder);
              },
            )
          ],
        ),
      ),
    );
  }
}
class TotalRevenueOrSpendingItem extends StatelessWidget {
  const TotalRevenueOrSpendingItem({
    super.key,
    required this.title,
    required this.amountOfMoney,
    required this.foreground,
  });
  final String title;
  final String amountOfMoney;
  final Color foreground;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const  TextStyle(color: colorTextBlack, fontSize: small, fontWeight: FontWeight.w500)),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation, child: child,
              );
            },
            child: MoneyVnd(
              fontSize: big,
              amount: double.parse(amountOfMoney),
              key: ValueKey(amountOfMoney),
              iconWidth: small,
              textColor: foreground,
            )
          // VndRichText(
          //   key: ValueKey(amountOfMoney),
          //   value: double.parse(amountOfMoney),
          //   color: foreground, fontSize: textBig, iconSize: 15,
          // ),
        )
      ],
    );
  }
}
class BodyOfPage extends StatelessWidget {
  const BodyOfPage({
    super.key,
    required this.records,
    required this.dashBorder,
  });

  final List records;
  final Border dashBorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: records.map((e){
        String date = e['date'];//yyyy-MM-dd
        // String dayOfTheWeekOfItem = showTheDayOFTheWeek(date);

        final dateSplited = date.split('-');//[yyyy, mm , dd]
        final String transformDay = dateSplited[2];
        final String transformMonth = dateSplited[1];
        final String transformYear = dateSplited[0];
        List<dynamic> records = e['records'];
        //init value
        double totalRevenueMoney = 0;
        double totalSpendingMoney = 0;
        for(var e in records){
          if(e['cash_flow_type'] == 0){
            totalSpendingMoney += double.parse(e['amount_of_money'][r'$numberDecimal']);
          }else {
            totalRevenueMoney += double.parse(e['amount_of_money'][r'$numberDecimal']);
          }
        }

        return Column(
          children: [
            //whole items
            Container(
              color: primaryColor,
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  //DateTime section
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        const VerticalDivider(color: secondaryColor,width: 0,thickness: 6),
                        //day
                        Padding(
                          padding: horizontalHalfPadding,
                          child: Text(transformDay, style: const TextStyle(
                              color: colorTextBlack, fontSize: 35, fontWeight: FontWeight.w700
                          )),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('foo', style: Theme.of(context).textTheme.bodyLarge),
                            subtitle: Text(
                                '$transformMonth/$transformYear',
                                style: const TextStyle(color: colorTextLabel, fontSize: small)
                            ),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Animate(
                                  effects: const [MoveEffect(begin: Offset(20, 0)), FadeEffect()],
                                  delay: const Duration(milliseconds: 100),
                                  child: MoneyVnd(
                                    amount: totalRevenueMoney,
                                    textColor: primaryColor,
                                    fontSize: small,
                                    iconWidth: tiny,
                                  ),
                                ),
                                Animate(
                                  effects: const [MoveEffect(begin: Offset(20, 0)), FadeEffect()],
                                  delay: const Duration(milliseconds: 100),
                                  child: MoneyVnd(
                                    amount: totalSpendingMoney,
                                    textColor: emergencyColor,
                                    fontSize: normal,
                                    iconWidth: small,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //record
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: dividerColor))
                      ),
                      child: Column(
                        children: records.map((e){
                          return Container(
                            decoration: BoxDecoration(
                                border: dashBorder
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20, // Adjust the width as needed
                                  child: CustomPaint(
                                    size: const Size(20, 1), // Set the width and height for the dashed line
                                    painter: HorizontalDashedLinePainter(),
                                  ),
                                ),
                                Expanded(
                                  child: MyListTitle(
                                    callback: (){
                                      context.push(RoutesName.addingWorkSpacePath);
                                    },
                                    leading: Image.asset(e['icon'], width: 35),
                                    title: e['name'],
                                    leftContentPadding: 0,
                                    rightContentPadding: 0,
                                    trailing: MoneyVnd(
                                      amount: double.parse(e['amount_of_money'][r'$numberDecimal']),
                                      textColor: e['cash_flow_type'] == 0? emergencyColor: secondaryColor,
                                      fontSize: normal,
                                      iconWidth: tiny,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )

                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      }).toList() ,
    );
  }
}
