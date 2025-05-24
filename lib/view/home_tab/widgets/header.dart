
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../generated/paths.dart';
class Header extends StatelessWidget {
  const Header({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rightActionHeaderWidgets = [
      {
        'iconPath': Assets.svgMagnifyingGlass,
        'callback': ()async{
        }
      },

      {
        'iconPath': Assets.svgBell,
        'callback': ()async{
        }
      },
      {
        'iconPath': Assets.svgCopilot,
        'callback': ()async{
          context.push(FinalRoutes.chatWithAIPath);
          await context.read<AppViewModel>().getUserPersonalizationDataForChatBot(context);
        }
      },
    ];
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
                          return const MoneyVnd(fontSize: 24, amount: 0);
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
                          return const MoneyVnd(fontSize: 24, amount: 0);
                        default :
                          return const MoneyVnd(fontSize: 24, amount: 0);
                      }
                    },
                  ),

                  const SizedBox(width: 12),
                  SvgContainer(
                    iconWidth: 24,
                    iconPath: Assets.svgEyes,
                    myIconColor: black,
                    callback: ()async {

                    },
                  ),
                ],
              ),
              Row(
                children: rightActionHeaderWidgets.map((e){
                  return Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SvgContainer(
                      iconWidth: 22,
                      myIconColor: black,
                      iconPath: e['iconPath'],
                      callback: e['callback'],
                    ),
                  );
                }).toList(),
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
