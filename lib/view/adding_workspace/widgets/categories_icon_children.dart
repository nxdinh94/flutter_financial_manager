import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/padding.dart';
import '../../../model/categories_icon_model.dart';
import '../../common_widget/divider.dart';
class CategoriesIconChildren extends StatelessWidget {
  const CategoriesIconChildren({
    super.key, required this.categoryChildren,
  });
  final CategoriesIconModel categoryChildren;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        children: [
          Flexible(
              child: SizedBox(width: 12, child: MyDivider())
          ),
          Flexible(
            child: ListTile(
              title: Text(categoryChildren.name),
              leading: Image.asset(categoryChildren.icon, width: 36),
              visualDensity: const VisualDensity(horizontal: -4),
              contentPadding: nonePadding,
              onTap: () {
                PickedIconModel pickedIcon = PickedIconModel(
                  id: categoryChildren.id,
                  iconPath: categoryChildren.icon,
                  name: categoryChildren.name,
                );
                context.pop(pickedIcon);
              },
            ),
          ),
        ],
      ),
    );
  }
}
