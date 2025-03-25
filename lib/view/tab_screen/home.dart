// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/my_column_chart.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/my_pie_chart.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/wallets_banner.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletViewModel>(context, listen: false).getIconsWalletType();
      Provider.of<WalletViewModel>(context, listen: false).getAllWallet();
      Provider.of<WalletViewModel>(context, listen: false).getExternalBank();
      Provider.of<AppViewModel>(context, listen: false).getIconCategoriesApi();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: defaultHalfPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MoneyVnd(fontSize: 24, amount: 999999999, iconWidth: 18),
                      const SizedBox(width: 12),
                      SvgContainer(
                        iconWidth: 22,
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
                      ),
                      const SizedBox(width: 24),
                      SvgContainer(
                        iconWidth: 22, myIconColor: Colors.black,
                        iconPath: Assets.svgBell
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
              const SizedBox(height: 12,),
              WalletBanner(),

              //Row chart
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){

                },
                child: Container(
                  color: primaryColor,
                  child: Column(
                    children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child:  MyColumnChart(
                                  data:  [
                                    CollumChartModel(2010, 35, secondaryColor),
                                    CollumChartModel(2011, 38, Colors.red),
                                  ]
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text('data')
                              ),
                            ],
                          ),

                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: MyPieChart(dataMap : <String, double>{
                            "Flutter": 5,
                            "React": 3,
                            "Xamarin": 2,
                            "Ionic": 2,
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap:(){

                    },
                    child: Text('Note history')
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}

