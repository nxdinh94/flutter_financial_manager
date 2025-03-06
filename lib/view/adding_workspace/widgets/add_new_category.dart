import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/text_container.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/padding.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          Padding(
            padding: horizontalPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Theme.of(context).colorScheme.secondary,
                child: SvgContainer(
                  iconWidth: 18,
                  iconPath: 'assets/svg/plus.svg',
                  myIconColor: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
          TextContainer(
            callback: () {
              context.push(RoutesName.addNewCategoryPath);
            },
            title: 'New category',
            textColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
