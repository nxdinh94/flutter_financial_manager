import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({
    super.key,
    required this.callback,
    required this.title,
    this.boxDecoration = const BoxDecoration(),
    this.isFontWeightBold = false,
    this.textColor = iosTextBlue,
  });

  final Future<void> Function()? callback; // Sửa lại kiểu dữ liệu callback
  final String title;
  final BoxDecoration boxDecoration;
  final bool isFontWeightBold;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (callback != null) {
          await callback!(); // Gọi callback thay vì chỉ await
        }
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: boxDecoration,
        child: Text(
          title,
          style: TextStyle(
            fontSize: big,
            color: textColor,
            fontWeight: isFontWeightBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
