import 'package:flutter/material.dart';
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/check_icon.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CheckPickedListTile<T> extends StatefulWidget {
  const CheckPickedListTile({
    super.key,
    required this.iconData,
    this.pickedIconId,
    this.subtitle,
    this.contentLeftPadding = 12,
    this.titleTextStyle,
    this.isShowBorderBottom = true,
    required this.onTap,
    this.isShowAnimate = true,
    this.onTrailingTap
  });

  final T iconData;
  final String ? pickedIconId;
  final Widget ? subtitle;
  final double contentLeftPadding;
  final bool  isShowBorderBottom;
  final TextStyle ? titleTextStyle;
  final Future<void> Function (PickedIconModel) onTap;
  final bool isShowAnimate;
  final void Function(PickedIconModel) ?  onTrailingTap;
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
        title: Animate(
          effects: widget.isShowAnimate? const [MoveEffect(begin: Offset(-20, 0)), FadeEffect()]:[],
          delay: const Duration(milliseconds: 100),
          child: Text(
            widget.iconData.name, style: widget.titleTextStyle ?? Theme.of(context).textTheme.bodyLarge
          ),
        ),
        leading: Animate(
          effects:  widget.isShowAnimate? const [MoveEffect(begin: Offset(-20, 0)), FadeEffect()]:[],
          delay: const Duration(milliseconds: 100),
          child: Image.asset(widget.iconData.icon, width: 36)
        ),
        visualDensity: const VisualDensity(horizontal: -4),
        contentPadding: EdgeInsets.only(right: 28, left: widget.contentLeftPadding),
        subtitle: Animate(
          effects: widget.isShowAnimate? const [MoveEffect(begin: Offset(-20, 0)), FadeEffect()]:[],
          delay: const Duration(milliseconds: 100),
          child: widget.subtitle ?? const SizedBox.shrink(),
        ),
        onTap: ()async {
          PickedIconModel pickedIcon = PickedIconModel(
            id: widget.iconData.id,
            icon: widget.iconData.icon,
            name: widget.iconData.name,
          );
          //return value
          await widget.onTap(pickedIcon);
        },
        // if the trailingCallback is null, then show the check icon
        // if the pickedIconId is equal to the iconData.id, then show the check icon
        trailing: widget.onTrailingTap == null ? ( widget.pickedIconId == widget.iconData.id ? const CheckIcon():
        const SizedBox.shrink()): SvgContainer(
          iconWidth: 18,
          iconPath: Assets.svgThreeDotsVertical,
          callback: (){
            PickedIconModel pickedIcon = PickedIconModel(
              id: widget.iconData.id,
              icon: widget.iconData.icon,
              name: widget.iconData.name,
            );
            widget.onTrailingTap!(pickedIcon);
          },
        ),
      ),
    );
  }
}
