import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common_widget/loading_animation.dart';

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
          borderRadius: BorderRadius.circular(12)
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
          Consumer<WalletViewModel>(
            builder: (context, value, child) {
              switch(value.allWalletData.status){
                case Status.LOADING:
                  return const Center(
                    child: LoadingAnimation(
                      iconSize: 30,
                      containerHeight: 50,
                    ),
                  );
                case Status.COMPLETED:
                  List<WalletModel> listData = value.allWalletData.data;
                  return listData.isEmpty ? Text('Empty'): Column(
                      children: listData.asMap().entries.map((e){
                        int index = e.key;
                        WalletModel val = e.value;
                        double balance = double.parse(val.accountBalance);
                        return MyListTitle(
                          callback: (){},
                          title: val.name,
                          leading: Image.asset(val.icon, width: 33,),
                          hideTrailing: true,
                          hideTopBorder: true,
                          hideBottomBorder: index == listData.length-1 ? true : false,
                          trailing: MoneyVnd(fontSize: big, amount: balance),
                          leftContentPadding: 0,
                          rightContentPadding: 0,
                        );
                      }).toList()
                  );
                case Status.ERROR:
                  return const Center(child: Text('Error'));
                default :
                  return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}