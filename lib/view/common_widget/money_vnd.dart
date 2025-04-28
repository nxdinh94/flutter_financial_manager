import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/utils/to_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
class MoneyVnd extends StatelessWidget {
  const MoneyVnd({
    super.key,
    required this.fontSize,
    this.fontWeight = FontWeight.w600,
    required this.amount,
    this.textColor = colorTextBlack,
    this.isWrapTextWithParentheses = false,
  });
  final double fontSize;
  final FontWeight fontWeight;
  final double amount;
  final Color textColor;
  final bool isWrapTextWithParentheses;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: isWrapTextWithParentheses ? '(' : '',
            style: TextStyle(
                fontWeight: fontWeight,
                fontSize:  fontSize +2,
                color: textColor
            ),
          ),
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
                iconWidth: fontSize -2,
                myIconColor: textColor,
                iconPath: Assets.svgVnd,
                containerSize: fontSize -2,
              ),
            ),
          ),
          TextSpan(
            text: isWrapTextWithParentheses ? ')' : '',
            style: TextStyle(
                fontWeight: fontWeight,
                fontSize: fontSize +2,
                color: textColor
            ),
          ),
        ]
      )
    );
  }
}
