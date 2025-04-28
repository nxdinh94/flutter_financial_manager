import 'package:flutter/material.dart';
class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.indent,this.endIndent});
  final double ? indent;
  final double ? endIndent;
  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent,
      endIndent: endIndent,
      thickness: 0.5,
    );
  }
}
