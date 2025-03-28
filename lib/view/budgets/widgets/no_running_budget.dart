import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class NoRunningBudget extends StatelessWidget {
  const NoRunningBudget({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: defaultPadding,
      width: screenWidth,
      height: screenHeight,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/another_icon/empty-box.png', height: 80, width: 80,),
          const SizedBox(height: 12,),
          Text('You have no budget', style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 6),
          Text(
            'Start saving money by creating budgets and we will help you stick to it',
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12,),

          SizedBox(
            width: screenWidth,
            child: ElevatedButton(
            onPressed: (){
              context.push(RoutesName.createUpdateBudgetPath);
            },
            child: const Text('Create a budget'))
          ),
        ],
      ),
    );
  }
}
