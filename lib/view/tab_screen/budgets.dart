import 'package:fe_financial_manager/constants/data_sample.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/view/budgets/widgets/no_running_budget.dart';
import 'package:fe_financial_manager/view_model/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../budgets/widgets/budget_items.dart';
class Budgets extends StatefulWidget {
  const Budgets({super.key});
  @override
  State<Budgets> createState() => _BudgetsState();
}

class _BudgetsState extends State<Budgets> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Budgets'),
        actions: [
          GestureDetector(
            onTap: (){
              context.push(FinalRoutes.createUpdateBudgetPath);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.add, size: 24,),
            )
          )
        ],
      ),
      body: Consumer<BudgetViewModel>(
        builder: (context, value, child) {
          List<dynamic> budgetList = value.allBudgetsData.data ?? [];
          switch(value.allBudgetsData.status){
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return const Center(child: Text('Something went wrong'));
            case Status.COMPLETED:
              if(value.allBudgetsData.data!.isEmpty){
                return const NoRunningBudget();
              }else{
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12,),
                      ...budgetList.map((value){
                        return BudgetItems(
                          data: value,
                          callback: ()async{
                            context.push(FinalRoutes.budgetDetailPath, extra: value);
                          },
                          paddingBottom: 6,
                        );
                      })
                    ]
                  ),
                );
              }
            default:
              return const Center(child: Text('Something went wrong'));
          }
        },
      )
    );
  }
}
