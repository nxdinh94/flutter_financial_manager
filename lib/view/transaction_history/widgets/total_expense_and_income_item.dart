import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:flutter/material.dart';
class TotalExpenseAndIncomeItem extends StatelessWidget {
  const TotalExpenseAndIncomeItem({
    super.key,
    required this.totalIncomeMoney,
    required this.title,
    this.color = secondaryColor,
  });

  final String totalIncomeMoney;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: defaultHalfPadding,
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation, child: child,
                    );
                  },
                  child: MoneyVnd(
                    fontSize: big,
                    amount: double.parse(totalIncomeMoney),
                    key: ValueKey(totalIncomeMoney),
                    textColor: color,
                  )
              )
            ],
          )
      ),
    );
  }
}
