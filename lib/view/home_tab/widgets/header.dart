import 'dart:convert';

import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultHalfPadding,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Consumer<WalletViewModel>(
                    builder: (context, value, child) {
                      switch(value.allWalletData.status){
                        case Status.LOADING:
                          return MoneyVnd(
                              fontSize: 24, amount: 0
                          );
                        case Status.COMPLETED:
                          List<WalletModel> listData = value.allWalletData.data;
                          double totalWalletBalance = 0;
                          for (var element in listData) {
                            double balance = double.parse(element.accountBalance);
                            totalWalletBalance += balance;
                          }
                          return MoneyVnd(
                              fontSize: 24, amount: totalWalletBalance
                          );
                        case Status.ERROR:
                          return MoneyVnd(
                              fontSize: 24, amount: 0
                          );
                        default :
                          return MoneyVnd(
                              fontSize: 24, amount: 0
                          );
                      }
                    },
                  ),

                  const SizedBox(width: 12),
                  SvgContainer(
                    iconWidth: 24,
                    iconPath: Assets.svgEyes,
                    myIconColor: black,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgContainer(
                    iconWidth: 22, myIconColor: black,
                    iconPath: Assets.svgMagnifyingGlass,
                    callback: (){
                      final sh = locator<SharedPreferences>();
                      Set<String> key = sh.getKeys();
                      print(key);
                      String appData = sh.getString('appData') ?? '';
                      print(jsonDecode(appData)['iconCategoriesData']);

                    },
                  ),
                  const SizedBox(width: 24),
                  SvgContainer(
                      iconWidth: 22, myIconColor: Colors.black,
                      iconPath: Assets.svgBell,
                    callback: ()async {
                        final sh = await locator<SharedPreferences>().remove('iconCategoriesData');
                    },
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Text('Total balance', style: Theme.of(context).textTheme.labelLarge,),
              SvgContainer(iconWidth: 14, iconPath: 'assets/svg/question-mark-circle.svg')
            ],
          ),
        ],
      ),
    );
  }
}
