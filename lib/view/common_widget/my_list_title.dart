import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyListTitle extends StatefulWidget {
  MyListTitle({
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
  });
  final String title;
  Widget ? subTitle;
  Widget ? leading;
  final VoidCallback callback;
  TextStyle titleTextStyle;
  double verticalContentPadding;
  double leftContentPadding;
  double rightContentPadding;
  double horizontalTitleGap;
  bool hideTrailing;
  bool hideTopBorder;
  bool hideBottomBorder;
  Widget ? trailing;
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
          effects: const [MoveEffect(begin: Offset(-20, 0)), FadeEffect()],
          delay: const Duration(milliseconds: 100),
          child: Text(
            widget.title,
            style: widget.titleTextStyle
          ),
        ),
        subtitle:  widget.subTitle,
        leading: Animate(
          effects: const [MoveEffect(begin: Offset(-20, 0)), FadeEffect()],
          delay: const Duration(milliseconds: 100),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 35.0,
              minWidth: 35.0,
              maxWidth: 80,
              maxHeight: 80
            ),
            child: widget.leading
          ),
        ),
        trailing: Visibility(
          visible: widget.hideTrailing,
          child: Animate(
            effects: const [MoveEffect(begin: Offset(20, 0)), FadeEffect()],
            delay: const Duration(milliseconds: 100),
            child: widget.trailing ?? const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
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
