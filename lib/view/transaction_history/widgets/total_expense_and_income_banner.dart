import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/view/transaction_history/widgets/total_expense_and_income_item.dart';
import 'package:flutter/material.dart';
class TotalExpenseAndIncomeBanner extends StatelessWidget {
  const TotalExpenseAndIncomeBanner({
    super.key,
    required this.totalIncomeMoney,
    required this.totalExpenseMoney,
  });

  final String totalIncomeMoney;
  final String totalExpenseMoney;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryColor,
      child: IntrinsicHeight(
        child: Row(
          children: [
            TotalExpenseAndIncomeItem(
              totalIncomeMoney: totalIncomeMoney, title: 'Total revenue',
            ),
            const VerticalDivider(thickness: .5, color: dividerColor),
            TotalExpenseAndIncomeItem(
              totalIncomeMoney: totalExpenseMoney, title: 'Total expense', color: emergencyColor,
            ),
          ],
        ),
      ),
    );
  }
}
