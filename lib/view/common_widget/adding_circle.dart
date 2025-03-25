import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';

class AddingCircle extends StatelessWidget {
  AddingCircle({
    super.key,
    this.iconWidth = 18,
    this.iconColor = white,
    this.containerSize = 24,
  });

  double iconWidth;
  Color iconColor;
  double containerSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        width: containerSize,
        height: containerSize,
        child: SvgContainer(
          iconWidth: iconWidth,
          iconPath: Assets.svgPlus,
          myIconColor: iconColor,
        ),
      ),
    );
  }
}
