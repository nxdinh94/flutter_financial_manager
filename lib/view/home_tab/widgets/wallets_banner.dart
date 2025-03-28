import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletBanner extends StatelessWidget {
  const WalletBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: horizontalPadding,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          SizedBox(
            height: 46,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My wallets', style: Theme.of(context).textTheme.titleLarge,),
                InkWell(
                  onTap: (){
                    context.push(FinalRoutes.allWalletsPath);
                  },
                  child: Text('See all',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: secondaryColor)
                  ),
                )
              ],
            ),
          ),
          MyDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: MyListTitle(
                  title: 'Tiền mặt', callback: (){},
                  leading: Image.asset('assets/account_type/bank.png', width: 33,),
                  hideTrailing: false,
                  leftContentPadding: 0,
                ),
              ),
              MoneyVnd(fontSize: big, amount: 999999999, iconWidth: 12,),
            ],
          )
        ],
      ),
    );
  }
}