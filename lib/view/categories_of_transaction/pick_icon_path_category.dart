import 'package:fe_financial_manager/constants/expenses_icon_category.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PickIconPathCategory extends StatelessWidget {
  const PickIconPathCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Icon'),
        leading: const CustomBackNavbar(),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: defaultPadding,
              child: Wrap(
                spacing: 45.0, // gap between adjacent chips
                runSpacing: 32.0, // gap between lines
                alignment: WrapAlignment.start,
                children: <Widget>[
                  ...expenseIconPathCategory.map((e) {
                    return GestureDetector(
                      onTap: (){
                        context.pop(e);
                      },
                      child: Image.asset(
                        e, width: 35
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
