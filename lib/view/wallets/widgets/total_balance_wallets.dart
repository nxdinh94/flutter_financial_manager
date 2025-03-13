import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:flutter/material.dart';
class TotalBalanceWallets extends StatelessWidget {
  const TotalBalanceWallets({super.key, required this.balance});
  final double balance;

  @override
  Widget build(BuildContext context) {
    return MyListTitle(
      callback: (){},
      title: 'Total',
      titleTextStyle: Theme.of(context).textTheme.titleLarge!,
      leading: Image.asset('assets/another_icon/global.png', width: 33,),
      subTitle: MoneyVnd(fontSize: normal, amount: balance, iconWidth: 12,),
      hideBottomBorder: false,
      hideTopBorder: false,
    );
  }
}
