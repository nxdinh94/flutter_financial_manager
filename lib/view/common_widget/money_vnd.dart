import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/utils/to_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
class MoneyVnd extends StatelessWidget {
  MoneyVnd({
    super.key,
    this.iconColor = colorTextBlack,
    this.iconWidth= 18,
    required this.fontSize,
    this.fontWeight = FontWeight.w600, required this.amount
  });
  double iconWidth;
  Color iconColor;
  final double fontSize;
  FontWeight fontWeight;
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          toVnd(123456789).toString(),
          style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize
          ),
        ),
        SvgContainer(
          iconWidth: iconWidth,
          myIconColor: iconColor,
          iconPath: 'assets/svg/vnd.svg',
        ),
      ],
    );
  }
}
