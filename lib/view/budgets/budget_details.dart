import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/view/budgets/widgets/area_chart.dart';
import 'package:fe_financial_manager/view/budgets/widgets/budget_items.dart';
import 'package:fe_financial_manager/view/budgets/widgets/suggestion_spending_money.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/dataForAreaChart.dart';
import '../../utils/routes/routes_name.dart';

class BudgetDetails extends StatefulWidget {
  const BudgetDetails({super.key, required this.dataToPassSpendingLimitItemWidget});
  final Map<String, dynamic> dataToPassSpendingLimitItemWidget;
  @override
  State<BudgetDetails> createState() => _BudgetDetailsState();
}

class _BudgetDetailsState extends State<BudgetDetails> {
  String name = '';
  Map<String, dynamic> spendingLimitToUpdate = {};

  @override
  void initState() {
    name = widget.dataToPassSpendingLimitItemWidget['name'];
    super.initState();
  }
  List<List<dynamic>> groupSameElementsByDay(List<dynamic> inputList) {
    // Map to store lists of elements
    Map<String, List<dynamic>> elementGroups = {};

    // Populate the map with elements from the input list
    for (var element in inputList){
      if (elementGroups.containsKey(element['occur_date'])) {
        elementGroups[element['occur_date']]!.add({
          'occur_date':'${element['occur_date']}',
          'amount_of_money': '${element['amount_of_money'][r'$numberDecimal']}'
        });
      } else {
        elementGroups[element['occur_date']] = [
          {
            'occur_date':'${element['occur_date']}',
            'amount_of_money': '${element['amount_of_money'][r'$numberDecimal']}'
          }
        ];
      }
    }

    // Extract the values from the map and return as a list of lists
    return elementGroups.values.toList();
  }
  List<List<dynamic>> groupSameElementsByCategoryParent(List<dynamic> inputList) {
    // Map to store lists of elements
    Map<String, List<dynamic>> elementGroups = {};

    // Populate the map with elements from the input list
    for (var element in inputList){
      if (elementGroups.containsKey(element['cash_flow_category_id'])) {
        elementGroups[element['cash_flow_category_id']]!.add(element);
      } else {
        elementGroups[element['cash_flow_category_id']] = [element];
      }
    }

    // Extract the values from the map and return as a list of lists
    return elementGroups.values.toList();
  }
  Map<String, dynamic> thisSpendingLimit = {
    'amount_of_money': {'\$numberDecimal': '5000000'},
    'actual_spending': {'\$numberDecimal': '2000000'},
    'should_spending': {'\$numberDecimal': '1500000'},
    'expected_spending': {'\$numberDecimal': '4500000'},
    'expense_records': [
      {
        'occur_date': '2025-03-20',
        'amount_of_money': {'\$numberDecimal': '500000'},
        'cash_flow_category_id': 'food'
      },
      {
        'occur_date': '2025-03-21',
        'amount_of_money': {'\$numberDecimal': '300000'},
        'cash_flow_category_id': 'food'
      },
      {
        'occur_date': '2025-03-21',
        'amount_of_money': {'\$numberDecimal': '700000'},
        'cash_flow_category_id': 'transport'
      },
      {
        'occur_date': '2025-03-22',
        'amount_of_money': {'\$numberDecimal': '1000000'},
        'cash_flow_category_id': 'entertainment'
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(name, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        leading: CustomBackNavbar(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgContainer(
              iconPath: 'assets/svg/pen-appbar.svg', iconWidth: 24, myIconColor: black,
              callback: ()async{
                context.push(
                    '${RoutesName.budgetsPath}/${RoutesName.createUpdateBudgetPath}',
                    extra: spendingLimitToUpdate
                );
              },
            ),

          )
        ],
      ),
      body: Consumer(
        builder: (context, value, child) {
          // Map<String, dynamic> thisSpendingLimit = value.specificSpendingLimit;
          spendingLimitToUpdate = thisSpendingLimit;
          List<ChartData> areaChartData = [];
          areaChartData = initialChartData;
          if(thisSpendingLimit.isEmpty){
            return SizedBox(
              height: 150,
              child: Center(
                child: Text('Không có bản ghi', style: Theme.of(context).textTheme.labelLarge),
              ),
            );
          }
          double initialMoney = double.parse(thisSpendingLimit['amount_of_money'][r'$numberDecimal']) ;
          double actualSpending = double.parse(thisSpendingLimit['actual_spending'][r'$numberDecimal']) ;
          double shouldSpending = double.parse(thisSpendingLimit['should_spending'][r'$numberDecimal']) ;
          double expectedSpending = double.parse(thisSpendingLimit['expected_spending'][r'$numberDecimal']) ;

          List<dynamic> expenseRecord = thisSpendingLimit['expense_records'];

          List<List<dynamic>> transformExpenseRecordByDay = groupSameElementsByDay(expenseRecord);//[[a,a,a],[b,b,b]]
          List<List<dynamic>> transformExpenseRecordByCateParent = groupSameElementsByCategoryParent(expenseRecord);//[[a,a,a],[b,b,b]]

          for(final item1 in transformExpenseRecordByDay){
            double totalGroupMoney = 0;
            int day = 0;
            for(final item2 in item1){
              DateTime occurDate = DateTime.parse(item2['occur_date']);
              day = occurDate.day;
              totalGroupMoney+=(double.parse(item2['amount_of_money'])/1000);//remove three latest number
            }
            areaChartData[day] = ChartData(day, totalGroupMoney);
          }

          return Container(
            color: Theme.of(context).colorScheme.surface,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hạn mức', style: Theme.of(context).textTheme.bodySmall),
                        MoneyVnd(fontSize: small, amount: initialMoney)
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  BudgetItems(itemSpendingLimit: widget.dataToPassSpendingLimitItemWidget),
                  const SizedBox(height: 12,),

                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    color: primaryColor,
                    child:  ListTile(
                      onTap: (){
                        // CustomNavigationHelper.router.push(
                        //   '${CustomNavigationHelper.detailSpendingLimitItemPath}/${CustomNavigationHelper.detailSpendingInSpendingLimitPath}',
                        //   extra: transformExpenseRecordByCateParent
                        // );
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      title: Text('Chi tiết khoản chi', style: Theme.of(context).textTheme.bodyLarge),
                      trailing: const Icon(Icons.keyboard_arrow_right, color: iconColor, size: 33),),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: primaryColor,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        MyAreaChart(areaChartData: areaChartData),
                        const Divider(indent: 30, endIndent: 30,),
                        const SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SuggestionSpendingMoney(
                              amount: actualSpending,
                              title: "Thực tế chi tiêu",
                              toolTipText: 'ST đã chi / Khoảng thời gian chi tiêu',
                            ),
                            SuggestionSpendingMoney(
                              amount: shouldSpending,
                              title: "Nên chi",
                              toolTipText: 'ST còn lại / Số ngày còn lại',
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: Divider(indent: 30,endIndent: 30,),
                        ),
                        SuggestionSpendingMoney(
                          amount: expectedSpending,
                          title: "Dự kiến chi tiêu",
                          toolTipText: 'Thực tế chi tiêu * Số ngày còn lại \n + ST đã chi',
                          isShowPerDay: false,
                          amountColor: secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}


