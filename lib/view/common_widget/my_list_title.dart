import 'package:flutter/material.dart';

class MyListTitle extends StatefulWidget {
  MyListTitle({
    super.key,
    required this.title,
    this.subTitle = '',
    this.leading,
    required this.callback,
    this.titleTextStyle
  });
  final String title;
  String subTitle;
  Widget ? leading;
  final VoidCallback callback;
  TextStyle ? titleTextStyle;
  @override
  State<MyListTitle> createState() => _MyListTitleState();
}

class _MyListTitleState extends State<MyListTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        title: Text(widget.title),
        titleTextStyle: widget.titleTextStyle,
        subtitle:  widget.subTitle.isEmpty ? null : Text(widget.subTitle),
        leading: widget.leading,
        trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
        visualDensity: VisualDensity(horizontal: 0, vertical : widget.subTitle.isEmpty ? 0 : -4),
        contentPadding: const EdgeInsets.only(left: 20, right: 10),
        onTap: widget.callback,
      ),
    );
  }
}
