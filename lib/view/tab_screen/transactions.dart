import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/transactions/widgets/right_arrow_rich_text.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../utils/date_time.dart';
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
            Consumer<TransactionViewModel>(
              builder: (context, value, child) {
                switch(value.transactionHistoryData.status){
                  case Status.LOADING:
                    return const Center(
                      child: LoadingAnimation(
                        iconSize: 80,
                        containerHeight: 500,
                      ),
                    );
                  case Status.COMPLETED:
                    Map<String, dynamic> data = value.transactionHistoryData.data!;

                    String totalIncomeMoney = data['total_all_income'];
                    String totalExpenseMoney = data['total_all_expense'];

                    return Container(
                      color: primaryColor,
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: defaultHalfPadding,
                                child: TotalRevenueOrSpendingItem(
                                  title: 'Total revenue',
                                  amountOfMoney: totalIncomeMoney,
                                  foreground: secondaryColor,
                                ),
                              ),
                            ),
                            const VerticalDivider(thickness: 1, color: dividerColor),
                            Expanded(
                              child: Padding(
                                padding: defaultHalfPadding,
                                child: TotalRevenueOrSpendingItem(
                                  title: 'Total expense',
                                  amountOfMoney: totalExpenseMoney,
                                  foreground: emergencyColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  case Status.ERROR:
                    return const Center(
                      child: Text(
                        'Error',
                        style: TextStyle(color: colorTextLabel, fontSize: normal),
                      ),
                    );
                    break;
                  default:
                    throw Exception('Unknown status');
                    break;
                }
              },
            ),
            const SizedBox(height: 12),
            Consumer<TransactionViewModel>(
              builder: (context, value, child) {
                switch(value.transactionHistoryData.status){
                  case Status.LOADING:
                    return const Center(
                      child: LoadingAnimation(
                        iconSize: 80,
                        containerHeight: 500,
                      ),
                    );
                  case Status.COMPLETED:
                    Map<String, dynamic> data = value.transactionHistoryData.data!;
                    Map<String, dynamic> records = data['transactions_by_date'] ??{};
                    return BodyOfPage(records: records, dashBorder: dashBorder);
                  case Status.ERROR:
                    return const Center(
                      child: Text(
                        'Error',
                        style: TextStyle(color: colorTextLabel, fontSize: normal),
                      ),
                    );
                    break;
                  default:
                    throw Exception('Unknown status');
                }

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
        Text(title, style: const  TextStyle(color: colorTextBlack, fontSize: normal, fontWeight: FontWeight.w500)),
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
              textColor: foreground,
            )
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

  final Map<String, dynamic> records;
  final Border dashBorder;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: records.entries.map((entry) {
        String date = entry.key;
        List<TransactionHistoryModel> items = entry.value['transactions'];
        final dateSplit = date.split('-');
        final String transformDay = dateSplit[2];
        final String transformMonth = dateSplit[1];
        final String transformYear = dateSplit[0];
        final String nameOfTheDay = DateTimeHelper.getNameOfDay(date);

        double totalRevenueMoney = double.parse(entry.value['total_income']);
        double totalSpendingMoney = double.parse(entry.value['total_expense']);
        return Column(
          children: [
            Container(
              color: primaryColor,
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        const VerticalDivider(color: secondaryColor, width: 0, thickness: 6),
                        Padding(
                          padding: horizontalHalfPadding,
                          child: Text(transformDay,
                            style: const TextStyle(
                              color: colorTextBlack,
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                            )),
                        ),
                        Expanded(
                          child: MyListTitle(
                            callback: (){},
                            title: nameOfTheDay,
                            subTitle: Text('$transformMonth/$transformYear',
                                style: const TextStyle(color: colorTextLabel, fontSize: small)),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MoneyVnd(
                                  amount: totalRevenueMoney,
                                  textColor: secondaryColor,
                                  fontSize: normal,
                                ),
                                const SizedBox(height: 6),
                                MoneyVnd(
                                  amount: totalSpendingMoney,
                                  textColor: emergencyColor,
                                  fontSize: normal,
                                ),
                              ],
                            ),
                            leftContentPadding: 0,
                            rightContentPadding: 0,
                            horizontalTitleGap: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: dividerColor)),
                      ),
                      child: Column(
                        children: items.map<Widget>((e) {
                          return Container(
                            decoration: BoxDecoration(border: dashBorder),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  child: CustomPaint(
                                    size: const Size(20, 1),
                                    painter: HorizontalDashedLinePainter(),
                                  ),
                                ),
                                Expanded(
                                  child: MyListTitle(
                                    callback: () async{
                                      dynamic isFromUpdateScreen = await context.push(RoutesName.addingWorkSpacePath, extra: e);
                                      if(!context.mounted) return;
                                      if(isFromUpdateScreen){
                                        await Provider.of<TransactionViewModel>(context, listen: false).getTransactionInRangeTime(
                                            {'fromDate' : '2025-03-01', 'toDate' : '2025-04-11', 'money_account_id' : ''});
                                      }
                                    },
                                    leading: Image.asset(e.transactionTypeCategory.icon, width: 38),
                                    title: e.transactionTypeCategory.name,
                                    subTitle: e.description.isNotEmpty ?
                                      Text(e.description, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontStyle: FontStyle.italic),) : null,
                                    leftContentPadding: 0,
                                    rightContentPadding: 0,
                                    trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        MoneyVnd(
                                          amount: double.parse(e.amountOfMoney),
                                          textColor: e.transactionTypeCategory.transactionType == 'Expense' ? emergencyColor : secondaryColor,
                                          fontSize: normal,
                                        ),
                                        const SizedBox(height: 6),
                                        MoneyVnd(
                                          amount: double.parse(e.moneyAccount.accountBalance!),
                                          textColor: colorTextLabel,
                                          fontSize: normal,
                                          isWrapTextWithParentheses: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }
}
