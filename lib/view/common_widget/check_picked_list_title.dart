import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/transaction_categories_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckPickedListTile<T> extends StatefulWidget {
  CheckPickedListTile({
    super.key,
    required this.iconData,
    this.pickedIconId = ''
  });

  final T iconData;
  String pickedIconId;

  @override
  State<CheckPickedListTile> createState() => _CheckPickedListTileState();
}

class _CheckPickedListTileState extends State<CheckPickedListTile> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.iconData.name),
      leading: Image.asset(widget.iconData.icon, width: 36),
      visualDensity: const VisualDensity(horizontal: -4),
      contentPadding: const EdgeInsets.only(right: 28),
      onTap: () {
        PickedIconModel pickedIcon = PickedIconModel(
          id: widget.iconData.id,
          icon: widget.iconData.icon,
          name: widget.iconData.name,
        );
        context.pop(pickedIcon);
      },
      trailing: widget.pickedIconId == widget.iconData.id ? SvgContainer(
          iconWidth: 121,
          iconPath: 'assets/svg/check-circle-fill.svg',
          myIconColor: secondaryColor,
      ):
      const SizedBox.shrink(),
    );
  }
}
