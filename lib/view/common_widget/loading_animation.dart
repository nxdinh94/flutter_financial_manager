import 'package:fe_financial_manager/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
    this.containerHeight = 400,
    this.iconSize = 80
  });
  final double containerHeight;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      child: LoadingAnimationWidget.inkDrop(
        color: secondaryColor,
        size: iconSize,
      ),
    );
  }
}
