import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';


class CustomToolTip extends StatelessWidget {
  final String tooltipText;

  const CustomToolTip({
    super.key, required this.tooltipText,
  });
  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      backgroundColor: Colors.black54,
      tailBaseWidth: 10,
      tailLength: 8,
      preferredDirection: AxisDirection.up,
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          tooltipText,
          style: const TextStyle(color: primaryColor),
          textAlign: TextAlign.center,
        ),
      ),
      child: Material(
        child: SvgPicture.asset(
          Assets.svgQuestionMarkRound,
          colorFilter: const ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
