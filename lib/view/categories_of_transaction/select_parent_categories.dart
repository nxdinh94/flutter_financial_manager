import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/view/common_widget/check_picked_list_title.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/transaction_categories_icon_model.dart';

class SelectParentCategories extends StatefulWidget {
  const SelectParentCategories({super.key});

  @override
  State<SelectParentCategories> createState() => _SelectParentCategoriesState();
}

class _SelectParentCategoriesState extends State<SelectParentCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Parent Category'),
      ),
      body: Expanded(
        child: Consumer<AppViewModel>(
          builder: (context, value, child) {
            switch(value.iconCategoriesData.status){
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                final expenseIconsList = value.iconCategoriesData.data?.categoriesIconListMap['expense'];
                // final incomeIconsList = value.iconCategoriesData.data?.categoriesIconListMap['income'];
                if (expenseIconsList == null || expenseIconsList.isEmpty) {
                  return const Center(child: Text("No icons available"));
                }
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    ...expenseIconsList.map<Widget>((e) {
                      CategoriesIconModel categoriesIconParent = e as CategoriesIconModel; // Proper casting
                      CheckPickedListTile(
                        iconData: categoriesIconParent,
                        onTap: (value) async{}
                      );
                    }).toList()
                  ],
                );
              case Status.ERROR:
                throw UnimplementedError();
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
