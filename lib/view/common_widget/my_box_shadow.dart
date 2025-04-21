import 'package:flutter/material.dart';
class MyBoxShadow extends StatelessWidget {
  const MyBoxShadow({super.key, required this.child, this.color = Colors.grey, required this.padding});
  final Widget child;
  final Color ? color;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color!.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: child
    );
  }
}
