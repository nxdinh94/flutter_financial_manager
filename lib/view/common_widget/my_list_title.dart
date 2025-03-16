import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:flutter/material.dart';

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
    this.horizontalTitleGap = 12,
    this.hideTrailing = true,
    this.hideBottomBorder = true,
    this.hideTopBorder = true,
  });
  final String title;
  Widget ? subTitle;
  Widget ? leading;
  final VoidCallback callback;
  TextStyle titleTextStyle;
  double verticalContentPadding;
  double leftContentPadding;
  double horizontalTitleGap;
  bool hideTrailing;
  bool hideTopBorder;
  bool hideBottomBorder;
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
        title: Text(widget.title, style: widget.titleTextStyle),
        subtitle:  widget.subTitle,
        leading: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 35.0,
            minWidth: 35.0,
            maxWidth: 80,
            maxHeight: 80
          ),
          child: widget.leading
        ),
        trailing: Visibility(
          maintainInteractivity: false,
          maintainState: false,
          visible: widget.hideTrailing,
          child: const Icon(Icons.arrow_forward_ios, size: 15,)
        ),
        visualDensity: VisualDensity(
          horizontal: 0,
          vertical : widget.verticalContentPadding
        ),
        contentPadding: EdgeInsets.only(left: widget.leftContentPadding , right: 10),
        onTap: widget.callback,
        horizontalTitleGap: widget.horizontalTitleGap,
      ),
    );
  }
}
