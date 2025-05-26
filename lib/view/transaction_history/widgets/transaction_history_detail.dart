import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/params_get_transaction_in_range_time.dart';
import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/view/common_widget/dash_line_painter/dash_line_painter.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class TransactionHistoryDetail extends StatelessWidget {
  const TransactionHistoryDetail({
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
                                      dynamic isFromUpdateScreen = await context.push(FinalRoutes.addingWorkSpacePath, extra: e);
                                      if(!context.mounted) return;
                                      if(isFromUpdateScreen){
                                        await Provider.of<TransactionViewModel>(context, listen: false).getTransactionInRangeTime(
                                            ParamsGetTransactionInRangeTime(from : '', to : '', moneyAccountId : ''));
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
