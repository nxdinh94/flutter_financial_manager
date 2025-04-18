import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:flutter/material.dart';
class ColumnChartLabel extends StatelessWidget {
  const ColumnChartLabel({
    super.key,
    required this.label,
    this.iconSize = 12,
    required this.color,
    required this.amount,
  });
  final String label;
  final double ? iconSize;
  final Color color;
  final double amount;


  @override
  Widget build(BuildContext context) {
    return MyListTitle(
      title: label,
      leading: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      minConstraintSize: 10,
      leftContentPadding: 0,
      rightContentPadding: 0,
      horizontalTitleGap: 0,
      trailing: MoneyVnd(amount: amount, fontSize: big, textColor: color,),
      callback: () {  },
    );
  }
}
