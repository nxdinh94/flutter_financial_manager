import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:flutter/material.dart';

class CreditInformation extends StatelessWidget {
  const CreditInformation({
    super.key, required this.currentAccountBalance, required this.moneyAccountCreditLimit, required this.availableAccountBalance,
  });

  final String currentAccountBalance;
  final String moneyAccountCreditLimit;
  final String availableAccountBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultHalfPadding,
      color: primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Credit limit', style: Theme.of(context).textTheme.labelLarge,),
              MoneyVnd(fontSize: normal, amount: double.parse(moneyAccountCreditLimit))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Available account balance',  style: Theme.of(context).textTheme.labelLarge,),
              MoneyVnd(fontSize: normal, amount: double.parse(availableAccountBalance))
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current account balance',  style: Theme.of(context).textTheme.labelLarge,),
                MoneyVnd(fontSize: normal, amount: double.parse(currentAccountBalance))
              ]
          ),

        ],
      ),
    );
  }
}
