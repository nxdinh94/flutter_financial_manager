import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/categories_icon_children.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../model/categories_icon_model.dart';

class CategoriesIconParent extends StatefulWidget {
  const CategoriesIconParent({super.key, required this.parentIcon});
  final CategoriesIconModel parentIcon;

  @override
  State<CategoriesIconParent> createState() => _CategoriesIconParentState();
}

class _CategoriesIconParentState extends State<CategoriesIconParent> {
  bool isExpanded = true;
  late final List<CategoriesIconModel> childrenIcon;

  @override
  void initState() {
    childrenIcon = widget.parentIcon.children;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: ExpansionTile(
        onExpansionChanged: (flag) {
          setState(() {
            isExpanded = flag;
          });
        },
        initiallyExpanded: true,
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            PickedIconModel pickedCategory = PickedIconModel(
              id : widget.parentIcon.id,
              iconPath: widget.parentIcon.icon,
              name: widget.parentIcon.name
            );
            context.pop(pickedCategory);
          },
          child: Text(widget.parentIcon.name)
        ),
        leading: Image.asset(widget.parentIcon.icon, width: 42,),
        controlAffinity: ListTileControlAffinity.trailing,

        trailing: childrenIcon.isEmpty ?
        const SizedBox.shrink() : (isExpanded ?
        const Icon(Icons.keyboard_arrow_up_rounded, color: iconColor,)
          : const Icon(Icons.keyboard_arrow_down_rounded, color: iconColor,)
        ),
        children: childrenIcon.isNotEmpty ? childrenIcon.map((v){
          CategoriesIconModel categoryIconChildren = v;
          return CategoriesIconChildren(categoryChildren: categoryIconChildren);
        }).toList() : [],
      ),
    );
  }
}

