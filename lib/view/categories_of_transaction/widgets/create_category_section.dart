import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/text_container.dart';
import 'package:fe_financial_manager/view/common_widget/adding_circle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants/padding.dart';
import '../../../view_model/app_view_model.dart';

class CreateCategorySection extends StatelessWidget {
  const CreateCategorySection({super.key});

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
            callback: () async{
              final result = await context.push(FinalRoutes.createNewCategoryPath);
              if(result == true){
                await context.read<AppViewModel>().getIconCategoriesApi();
              }

            },
            title: 'New category',
            textColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}

