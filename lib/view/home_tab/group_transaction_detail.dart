import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/params_get_transaction_in_range_time.dart';
import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/font_size.dart';
import '../../model/picked_icon_model.dart';
import '../common_widget/money_vnd.dart';

class GroupTransactionDetail extends StatefulWidget {
  const GroupTransactionDetail({
    super.key,
    required this.parentName,
    required this.transactionType,
  });

  final String parentName;
  final String transactionType;

  @override
  State<GroupTransactionDetail> createState() => _GroupTransactionDetailState();
}

class _GroupTransactionDetailState extends State<GroupTransactionDetail> {

  List<TransactionHistoryModel> getTransactionList(
      TransactionViewModel viewModel, String parentName, String type) {

    final Map<PickedIconModel, dynamic> data = type.contains('Expense')
        ? viewModel.expenseTransactionForDetailSummary
        : viewModel.incomeTransactionForDetailSummary;

    for (final entry in data.entries) {
      if (entry.key.name == parentName) {
        return entry.value;
      }
    }
    return [];
  }

  Future<void> handleTransactionUpdate(BuildContext context, TransactionHistoryModel transaction) async {
    dynamic isFromUpdateScreen = await context.push(
        FinalRoutes.addingWorkSpacePath,
        extra: transaction
    );
    if (!context.mounted) return;

    if (isFromUpdateScreen) {
      ParamsGetTransactionInRangeTime params = context.read<TransactionViewModel>().paramsGetTransactionChartInRangeTime;
      await Provider.of<TransactionViewModel>(context, listen: false)
          .getTransactionForChart(params,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parentName),
        leading: CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Consumer<TransactionViewModel>(
          builder: (context, viewModel, child) {
            final List<TransactionHistoryModel> transactions = getTransactionList(
                viewModel,
                widget.parentName,
                widget.transactionType
            );

            return Column(
              children: transactions.map((transaction) {
                return MyListTitle(
                  callback: () => handleTransactionUpdate(context, transaction),
                  title: transaction.transactionTypeCategory.name,
                  leading: Image.asset(
                    transaction.transactionTypeCategory.icon,
                    width: 35,
                    height: 35,
                  ),
                  hideBottomBorder: false,
                  leftContentPadding: 12,
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MoneyVnd(
                        amount: double.parse(transaction.amountOfMoney),
                        fontSize: big,
                        textColor: transaction.transactionTypeCategory.transactionType == 'Income'
                            ? secondaryColor
                            : expenseColumnChartColor,
                      ),
                      const SizedBox(height: 1),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: SvgContainer(
                                iconWidth: 14,
                                iconPath: Assets.svgWallet,
                              ),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            TextSpan(
                              text: transaction.moneyAccount!.name,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
