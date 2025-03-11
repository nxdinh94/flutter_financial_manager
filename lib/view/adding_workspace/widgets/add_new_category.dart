import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/text_container.dart';
import 'package:fe_financial_manager/view/common_widget/adding_circle.dart';
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
            child: AddingCircle(),
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

