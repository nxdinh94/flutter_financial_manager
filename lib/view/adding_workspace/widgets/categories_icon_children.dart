import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/check_picked_list_title.dart';
import 'package:flutter/material.dart';

import '../../../model/transaction_categories_icon_model.dart';
import '../../common_widget/divider.dart';
class CategoriesIconChildren extends StatelessWidget {
  const CategoriesIconChildren({
    super.key, required this.categoryChildren,
    required this.onItemTap,
    this.pickedCategoryId
  });
  final CategoriesIconModel categoryChildren;
  final Future<void> Function(PickedIconModel) onItemTap;
  final String ? pickedCategoryId;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(width: 12, child: MyDivider()),
          Expanded(
            child: CheckPickedListTile<CategoriesIconModel>(
              iconData: categoryChildren,
              pickedIconId: pickedCategoryId,
              contentLeftPadding: 0,
              isShowBorderBottom: false,
              onTap: onItemTap,
            )
          ),
        ],
      ),
    );
  }
}
