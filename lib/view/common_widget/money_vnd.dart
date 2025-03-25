import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/utils/to_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
class MoneyVnd extends StatelessWidget {
  MoneyVnd({
    super.key,
    this.iconWidth= 18,
    required this.fontSize,
    this.fontWeight = FontWeight.w600,
    required this.amount,
    this.textColor = colorTextBlack
  });
  double iconWidth;
  final double fontSize;
  FontWeight fontWeight;
  final double amount;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              toVnd(amount).toString(),
              style: TextStyle(
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: textColor
              ),
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgContainer(
                iconWidth: iconWidth,
                myIconColor: textColor,
                iconPath: 'assets/svg/vnd.svg',
                containerSize: iconWidth,
              ),
            ),
          ),
        ]
      )
    );
  }
}
