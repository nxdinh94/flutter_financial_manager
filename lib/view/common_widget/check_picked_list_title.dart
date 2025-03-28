import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/check_icon.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckPickedListTile<T> extends StatefulWidget {
  CheckPickedListTile({
    super.key,
    required this.iconData,
    this.pickedIconId,
    this.subtitle,
    this.contentLeftPadding = 12,
    this.titleTextStyle,
    this.isShowBorderBottom = true,
    required this.onTap,
    this.onReturnWholeItem
  });

  final T iconData;
  final void Function(dynamic) ? onReturnWholeItem;
  String ? pickedIconId;
  Widget ? subtitle;
  double contentLeftPadding;
  bool  isShowBorderBottom;
  TextStyle ? titleTextStyle;
  final void Function (PickedIconModel) onTap;
  @override
  State<CheckPickedListTile> createState() => _CheckPickedListTileState();
}

class _CheckPickedListTileState extends State<CheckPickedListTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: widget.isShowBorderBottom ?
          const Border(bottom: BorderSide(color: dividerColor, width: 0.5)):
          const Border(),
      ),
      child: ListTile(
        title: Text(widget.iconData.name, style: widget.titleTextStyle ?? Theme.of(context).textTheme.bodyLarge),
        leading: Image.asset(widget.iconData.icon, width: 36),
        visualDensity: const VisualDensity(horizontal: -4),
        contentPadding: EdgeInsets.only(right: 28, left: widget.contentLeftPadding),
        subtitle: widget.subtitle ,
        onTap: () {
          PickedIconModel pickedIcon = PickedIconModel(
            id: widget.iconData.id,
            icon: widget.iconData.icon,
            name: widget.iconData.name,
          );
          //return value
          widget.onTap(pickedIcon);
          //return root data
          if(widget.onReturnWholeItem != null){
            widget.onReturnWholeItem!(widget.iconData);
          }
        },
        trailing: widget.pickedIconId == widget.iconData.id ? const CheckIcon():
        const SizedBox.shrink(),
      ),
    );
  }
}
