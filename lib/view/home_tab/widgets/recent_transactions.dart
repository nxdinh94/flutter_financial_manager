import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/params_get_transaction_in_range_time.dart';
import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/view/common_widget/empty_value_screen.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../common_widget/loading_animation.dart';
import '../../common_widget/my_list_title.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: horizontalHalfPadding,
          child: Text('Recent transactions', style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500
          )),
        ),
        const SizedBox(height: 6),
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
                Map<String, dynamic>  data = value.transactionHistoryData.data as Map<String, dynamic>;
                Map<String, dynamic> records = data['transactions_by_date'] ??{};

                if(records.isEmpty){
                  return const EmptyValueScreen(title: 'You have no transactions yet',);
                }
                if(records.entries.length >3){
                  records = Map<String, dynamic>.fromEntries(records.entries.take(3));
                }

                return Container(
                  padding: horizontalHalfPadding,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Column(
                    children: records.entries.map((entry) {
                      List<TransactionHistoryModel> items = entry.value['transactions'];
                      return Column(
                        children: items.map<Widget>((e) {
                          return MyListTitle(
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
                            hideTopBorder: true,
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
                                  amount: double.parse(e.moneyAccount!.accountBalance!),
                                  textColor: colorTextLabel,
                                  fontSize: normal,
                                  isWrapTextWithParentheses: true,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                );
              case Status.ERROR:
                return const Center(
                  child: Text(
                    'Error', style: TextStyle(color: colorTextLabel, fontSize: normal),
                  ),
                );
              default:
                throw Exception('Unknown status');
            }

          },
        ),
      ],
    );
  }
}
