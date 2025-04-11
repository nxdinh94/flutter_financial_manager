import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:flutter/material.dart';

import '../../common_widget/custom_tooltip.dart';
class SuggestionSpendingMoney extends StatelessWidget {
  SuggestionSpendingMoney({
    super.key,
    required this.amount,
    required this.title,
    required this.toolTipText,
    this.isShowPerDay = true,
    this.amountColor = colorTextBlack
  });

  final double amount;
  Color amountColor;
  final String title;
  final String toolTipText;
  bool isShowPerDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text:  TextSpan(
            children: [
              TextSpan(
                  text: title,
                  style: Theme.of(context).textTheme.labelMedium
              ),
              const TextSpan(text: ' '),
              WidgetSpan(
                  child: CustomToolTip(
                    tooltipText: toolTipText,
                  ),
                  alignment: PlaceholderAlignment.middle
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                  child: MoneyVnd(
                    amount: amount,
                    fontSize: small,
                    textColor: amountColor,
                  ),
                  alignment: PlaceholderAlignment.middle
              ),
              const TextSpan(text: ' '),
              isShowPerDay ? TextSpan(text: '/day',  style: Theme.of(context).textTheme.labelSmall) : const TextSpan(),
            ],
          ),
        ),
      ],
    );
  }
}
