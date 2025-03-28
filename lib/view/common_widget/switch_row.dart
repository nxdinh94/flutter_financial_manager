import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:flutter/material.dart';

class SwitchRow extends StatefulWidget {
  const SwitchRow({
    super.key,
    required this.flag,
    required this.callback, required this.text,
    this.isShowBorder = false,
  });

  final bool flag;
  final bool isShowBorder;
  final ValueChanged<bool> callback;
  final String text;

  @override
  State<SwitchRow> createState() => _SwitchRowState();
}

class _SwitchRowState extends State<SwitchRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: horizontalHalfPadding,
      decoration: BoxDecoration(
        color: primaryColor,
        border: widget.isShowBorder ?  Border.all(width: 0.5, color: dividerColor) : const Border()
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.text, style: Theme.of(context).textTheme.bodyLarge,),
          SizedBox(
            width: 54,
            child: Switch(
              value: widget.flag,
              onChanged: widget.callback,
            ),
          ),
        ],
      ),
    );
  }
}
