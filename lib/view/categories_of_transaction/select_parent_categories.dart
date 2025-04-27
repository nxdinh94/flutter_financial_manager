import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/check_picked_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/transaction_categories_icon_model.dart';

class SelectParentCategories extends StatefulWidget {
  const SelectParentCategories({
    super.key,
    required this.onTap,
    required this.selectedTransactionTypeId
  });
  final Future<void> Function(PickedIconModel) onTap;
  final String selectedTransactionTypeId;
  @override
  State<SelectParentCategories> createState() => _SelectParentCategoriesState();
}

class _SelectParentCategoriesState extends State<SelectParentCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Parent Category'),
        leading: const CustomBackNavbar(),
      ),
      body: Consumer<AppViewModel>(
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ...expenseIconsList.map((e) {
                      CategoriesIconModel categoriesIconParent = e as CategoriesIconModel; // Proper casting
                      return CheckPickedListTile<CategoriesIconModel>(
                        iconData: categoriesIconParent,
                        onTap: widget.onTap
                      );
                    }).toList()
                  ],
                ),
              );
            case Status.ERROR:
              throw UnimplementedError();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
