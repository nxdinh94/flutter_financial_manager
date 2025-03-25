import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/data_sample.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/budgets/widgets/no_running_budget.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../budgets/widgets/budget_items.dart';
class Budgets extends StatefulWidget {
  const Budgets({super.key});
  @override
  State<Budgets> createState() => _BudgetsState();
}

class _BudgetsState extends State<Budgets> {
  bool isHaveBudget = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Running Budgets'),
        actions: [
          TextButton(onPressed: (){
            context.push('${RoutesName.budgetsPath}/${RoutesName.createUpdateBudgetPath}');
          }, child: Text('Add'))
        ],
      ),
      body: isHaveBudget?  SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12,),
            ...budgetList.map((value){
            return BudgetItems(
              itemSpendingLimit: value,
              callback: ()async{
                context.push('${RoutesName.budgetsPath}/${RoutesName.budgetDetailPath}', extra: value);
              },
              paddingBottom: 6,
            );
          })
          ]
        ),
      ) : NoRunningBudget()
    );
  }
}
