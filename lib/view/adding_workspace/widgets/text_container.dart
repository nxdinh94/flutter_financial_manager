import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/font_size.dart';


class TextContainer extends StatelessWidget {
  TextContainer({
    super.key,
    required this.callback,
    required this.title,
    this.boxDecoration = const BoxDecoration(),
    this.isFontWeightBold = false,
    this.textColor = iosTextBlue,
  });
  final VoidCallback callback;
  final String title;
  BoxDecoration boxDecoration;
  bool isFontWeightBold;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: boxDecoration,
        child: Text(title, style: TextStyle(
            fontSize: big,
            color: textColor,
            fontWeight: isFontWeightBold ? FontWeight.w700 : FontWeight.w400
        )),
      ),
    );
  }
}
