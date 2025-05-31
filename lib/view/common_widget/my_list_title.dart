import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyListTitle extends StatefulWidget {
  const MyListTitle({
    super.key,
    required this.title,
    this.subTitle,
    this.leading,
    required this.callback,
    this.titleTextStyle = const TextStyle(
      color: colorTextBlack,
      fontSize: big,
      fontWeight: FontWeight.w500
    ),
    this.verticalContentPadding = 0,
    this.leftContentPadding = 20,
    this.rightContentPadding = 10,
    this.horizontalTitleGap = 12,
    this.hideTrailing = true,
    this.hideBottomBorder = true,
    this.hideTopBorder = true,
    this.trailing,
    this.isShowAnimate = true,
    this.minConstraintSize = 35,
    this.trailingCallback
  });
  final String title;
  final Widget ? subTitle;
  final Widget ? leading;
  final VoidCallback callback;
  final TextStyle titleTextStyle;
  final double verticalContentPadding;
  final double leftContentPadding;
  final double rightContentPadding;
  final double horizontalTitleGap;
  final bool hideTrailing;
  final bool hideTopBorder;
  final bool hideBottomBorder;
  final Widget ? trailing;
  final bool isShowAnimate;
  final double minConstraintSize;
  final VoidCallback ? trailingCallback;
  @override
  State<MyListTitle> createState() => _MyListTitleState();
}

class _MyListTitleState extends State<MyListTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          border: Border(
            top: widget.hideTopBorder ? const BorderSide(color: Colors.transparent):
            const BorderSide(color: dividerColor, width: 0.5),
            bottom: widget.hideBottomBorder ? const BorderSide(color: Colors.transparent):
            const BorderSide(color: dividerColor, width: 0.5),
        )
      ),
      child: ListTile(
        title: Animate(
          effects: widget.isShowAnimate? const [MoveEffect(begin: Offset(-20, 0)), FadeEffect()]:[],
          delay: const Duration(milliseconds: 100),
          child: Text(
            widget.title,
            style: widget.titleTextStyle
          ),
        ),
        subtitle:  widget.subTitle,
        leading: widget.leading  == null ? null: Animate(
          effects:  widget.isShowAnimate? const [MoveEffect(begin: Offset(-20, 0)), FadeEffect()]:[],
          delay: const Duration(milliseconds: 100),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: widget.minConstraintSize,
              minWidth: widget.minConstraintSize,
              maxWidth: 80,
              maxHeight: 80
            ),
            child: widget.leading
          ),
        ),
        trailing: Visibility(
          visible: widget.hideTrailing,
          child: Animate(
            effects: widget.isShowAnimate? const [MoveEffect(begin: Offset(20, 0)), FadeEffect()] : [],
            delay: const Duration(milliseconds: 100),
            child:  widget.trailing ?? (widget.trailingCallback == null ? const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ) : SvgContainer(iconWidth: 16, iconPath: Assets.svgDelete, callback: widget.trailingCallback,)),
          )
        ),
        visualDensity: VisualDensity(
          horizontal: 0,
          vertical : widget.verticalContentPadding
        ),
        contentPadding: EdgeInsets.only(left: widget.leftContentPadding , right: widget.rightContentPadding),
        onTap: widget.callback,
        horizontalTitleGap: widget.horizontalTitleGap,
      ),
    );
  }
}
