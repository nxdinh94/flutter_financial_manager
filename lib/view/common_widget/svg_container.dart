import 'package:fe_financial_manager/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgContainer extends StatelessWidget {
  SvgContainer({
    super.key,
    required this.iconWidth,
    required this.iconPath,
    this.myIconColor = iconColor,
    this.containerSize = 20,
    this.callback,
    this.containerColor = Colors.transparent,

  });
  final double iconWidth;
  final String iconPath;
  Color myIconColor;
  double containerSize;
  VoidCallback ? callback;
  final Color containerColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback ?? (){},
      child: Container(
        alignment: Alignment.center, // <---- The magic
        color: containerColor,
        width: containerSize,
        height: containerSize,
        child: SvgPicture.asset(
          iconPath,
          width: iconWidth,
          colorFilter: ColorFilter.mode(myIconColor, BlendMode.srcIn),
        )
      ),
    );
  }
}
