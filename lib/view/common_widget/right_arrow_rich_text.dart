import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';

class RightArrowRichText extends StatelessWidget {
  const RightArrowRichText({
    super.key,
    this.color = secondaryColor,
    this.fontSize = big,
    this.fontWeight = FontWeight.w600,
    required this.text,
    this.iconSize = 28
  });
  final Color color;
  final double fontSize;
  final double iconSize;
  final FontWeight fontWeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text:  TextSpan(
          text: text,
          style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
          children: [
            WidgetSpan(
              child: Icon(Icons.keyboard_arrow_right, size: iconSize, color: color),
              alignment: PlaceholderAlignment.middle,
            )
          ]
      ),
    );
  }
}
