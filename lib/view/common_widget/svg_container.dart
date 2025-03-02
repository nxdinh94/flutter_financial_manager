import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgContainer extends StatelessWidget {
  const SvgContainer({super.key, required this.iconWidth, required this.iconPath});
  final double iconWidth;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center, // <---- The magic
        width: 10,
        height: 10,
        child: SvgPicture.asset(
          iconPath,
          width: iconWidth,
        )
    );
  }
}
