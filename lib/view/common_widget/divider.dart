import 'package:flutter/material.dart';
class MyDivider extends StatelessWidget {
  MyDivider({super.key, this.indent,this.endIndent});
  double ? indent;
  double ? endIndent;
  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent,
      endIndent: endIndent,
      thickness: 0.5,
    );
  }
}
