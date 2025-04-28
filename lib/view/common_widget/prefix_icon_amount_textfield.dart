
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';

class PrefixIconAmountTextfield extends StatelessWidget {
  const PrefixIconAmountTextfield({super.key, this.width= 49, this.height = 30});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height, width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: iconColor, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: SvgContainer(
          iconWidth: 30,
          iconPath: Assets.svgVnd,
        )
    );
  }
}
