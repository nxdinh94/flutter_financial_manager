import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';

class CheckIcon extends StatelessWidget {
  const CheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgContainer(
      iconWidth: 121,
      iconPath: 'assets/svg/check-circle-fill.svg',
      myIconColor: secondaryColor,
    );
  }
}

