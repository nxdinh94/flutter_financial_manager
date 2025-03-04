import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';

class MyListTitle extends StatefulWidget {
  MyListTitle({
    super.key,
    required this.title,
    this.subTitle = '',
    this.leading,
    required this.callback,
    this.titleTextStyle = const TextStyle(
      color: colorTextBlack,
      fontSize: normal,
      fontWeight: FontWeight.w500
    ),
    this.verticalContentPadding = 0
  });
  final String title;
  String subTitle;
  Widget ? leading;
  final VoidCallback callback;
  TextStyle titleTextStyle;
  double verticalContentPadding;
  @override
  State<MyListTitle> createState() => _MyListTitleState();
}

class _MyListTitleState extends State<MyListTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        title: Text(widget.title, style: widget.titleTextStyle),
        subtitle:  widget.subTitle.isEmpty ? null : Text(widget.subTitle),
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 40.0,
            minWidth: 40.0
          ),
          child: widget.leading
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
        visualDensity: VisualDensity(
          horizontal: 0,
          vertical : widget.verticalContentPadding
        ),
        contentPadding: const EdgeInsets.only(left: 20, right: 10),
        onTap: widget.callback,
        horizontalTitleGap: 12,
      ),
    );
  }
}
