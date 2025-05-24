import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/right_arrow_rich_text.dart';
import 'package:flutter/material.dart';
class ChooseRangeTimeSection extends StatefulWidget {
  const ChooseRangeTimeSection({
    super.key,
    required this.selectedTimeToShow,
    required this.onSelectRangeTime,
  });
  final Future<void> Function() onSelectRangeTime;
  final String selectedTimeToShow;
  @override
  State<ChooseRangeTimeSection> createState() => _ChooseRangeTimeSectionState();
}
class _ChooseRangeTimeSectionState extends State<ChooseRangeTimeSection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()async{
        await widget.onSelectRangeTime();
      },
      child: Container(
        color: primaryColor,
        padding: defaultHalfPadding,
        child: Center(
            child: RightArrowRichText(
                text: widget.selectedTimeToShow,
                color: secondaryColor, fontWeight: FontWeight.w500
            )
        ),
      ),
    );
  }
}