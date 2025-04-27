import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/view/budgets/widgets/area_chart.dart';
import 'package:fe_financial_manager/view/budgets/widgets/budget_items.dart';
import 'package:fe_financial_manager/view/budgets/widgets/suggestion_spending_money.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/data_for_area_chart.dart';
import '../../utils/routes/routes_name.dart';

class BudgetDetails extends StatefulWidget {
  const BudgetDetails({
    super.key, required this.data
  });
  final Map<String, dynamic> data;
  @override
  State<BudgetDetails> createState() => _BudgetDetailsState();
}

class _BudgetDetailsState extends State<BudgetDetails> {
  String name = '';
  List<ChartData> areaChartData = [];
  double initialMoney = 0;
  double actualSpending = 0;
  double shouldSpending = 0;
  double expectedSpending = 0;
  List<dynamic> expenseRecord = [];
  List<List<dynamic>> transformExpenseRecordByDay = [];
  List<List<dynamic>> transformExpenseRecordByCateParent = [];
  @override
  void initState() {
    name = widget.data['budget']['name'];
    initialMoney = double.parse(widget.data['budget']['amount_of_money'].toString());
    actualSpending = double.parse(widget.data['actual_expenses'].toString());
    shouldSpending = double.parse(widget.data['should_expenses'].toString());
    expectedSpending = double.parse(widget.data['expected_expenses'].toString());
    expenseRecord = widget.data['budget']['transactions'];
    areaChartData = initialChartData.map((e) => ChartData(e.x, e.y)).toList();
    transformExpenseRecordByDay = groupSameElementsByDay(expenseRecord);//[[a,a,a],[b,b,b]]
    transformExpenseRecordByCateParent = groupSameElementsByCategoryParent(expenseRecord);//[[a,a,a],[b,b,b]]
    // calculate data for areaChart
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
          'amount_of_money': '${element['amount_of_money']}'
        });
      } else {
        elementGroups[element['occur_date']] = [
          {
            'occur_date':'${element['occur_date']}',
            'amount_of_money': '${element['amount_of_money']}'
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
      if (element['parent_id'] != null ) {
        if(elementGroups.containsKey(element['id'])){
          elementGroups[element['id']]!.add(element);
        }else {
          elementGroups[element['id']] = [element];
        }
      } else {
        elementGroups[element['id']] = [element];
      }
    }

    // Extract the values from the map and return as a list of lists
    return elementGroups.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(name, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        leading: const CustomBackNavbar(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgContainer(
              iconPath: Assets.svgUpdate, iconWidth: 24, containerSize: 40, myIconColor: Colors.black,
              callback: ()async{
                dynamic result = await context.push(FinalRoutes.createUpdateBudgetPath, extra: widget.data);
                if(!mounted) return;
                if(result){
                  await context.read<BudgetViewModel>().getAllBudgets(context);
                }
              },
            ),

          )
        ],
      ),
      body: Container(
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
              BudgetItems(data: widget.data),
              const SizedBox(height: 12,),

              // MyListTitle(
              //   callback: (){},
              //   title: 'Detail expenses',
              //   titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
              //   leftContentPadding: 12,
              // ),
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
      ),
    );
  }
}


