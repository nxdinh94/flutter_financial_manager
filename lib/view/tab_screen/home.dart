// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/my_column_chart.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/my_pie_chart.dart';
import 'package:fe_financial_manager/view/home_tab/widgets/wallets_banner.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../model/wallet_model.dart';

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
      Provider.of<TransactionViewModel>(context, listen: false).getTransaction(
          {'fromDate' : '2025-03-01', 'toDate' : '2025-04-11', 'walletId' : ''});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 6),
            //Header
            Header(),

            const SizedBox(height: 12,),
            WalletBanner(),
            const SizedBox(height: 12,),
            //Row chart
            ChartSection(),
            const SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
}

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
        ],
      ),
    );
  }
}

class ChartSection extends StatelessWidget {
  const ChartSection({
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
      child: Consumer<TransactionViewModel>(
        builder: (context, value, child) {
          switch(value.transactionHistoryData.status){
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.COMPLETED:
              double expense =double.parse(value.transactionHistoryData.data!['total_all_expense']);
              double income = double.parse(value.transactionHistoryData.data!['total_all_income']);
              double balance = income-expense;
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Financial Summary', style: Theme.of(context).textTheme.titleLarge,),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Today',
                            style: Theme.of(context).textTheme.labelMedium,
                            children: const [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 25,
                                )
                              ),
                            ]
                        ),

                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 4,
                        child:  SizedBox(
                          height: 160,
                          child: MyColumnChart(
                              data:  [
                                ColumnChartModel(1, income, secondaryColor),
                                ColumnChartModel(2, expense, expenseColumnChartColor),
                              ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ColumnLabels(
                                color: secondaryColor, label: 'Income', amount: income,
                              ),
                              ColumnLabels(
                                color: expenseColumnChartColor, label: 'Expense', amount: expense,
                              ),
                              MyDivider(),
                              SizedBox(height: 12,),
                              MoneyVnd(fontSize: big, amount: balance)
                            ],
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 48),
                  // Only show if there are expenses
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
                  ),
                  SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Note history',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: secondaryColor),
                            children: const [
                              WidgetSpan(child: Icon(Icons.arrow_forward_ios_rounded, size: 15, color: secondaryColor)),
                            ]
                        ),

                      )
                    ],
                  ),
                ],
              );
            case Status.ERROR:
              return const Center(child: Text('Error'));
            default :
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class ColumnLabels extends StatelessWidget {
  const ColumnLabels({
    super.key,
    required this.label,
    this.iconSize = 12,
    required this.color,
    required this.amount,
  });
  final String label;
  final double ? iconSize;
  final Color color;
  final double amount;


  @override
  Widget build(BuildContext context) {
    return MyListTitle(
      title: 'Income',
      leading: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
      minConstraintSize: 10,
      leftContentPadding: 0,
      rightContentPadding: 0,
      horizontalTitleGap: 0,
      trailing: MoneyVnd(amount: amount, fontSize: big, textColor: color,),
      callback: () {  },
    );
  }
}

