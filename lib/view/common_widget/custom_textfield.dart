import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'svg_container.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.hideLegend = true,
    this.legend,
    this.textInputType  = TextInputType.text,
    this.prefixIcon,
    this.fontSize = normal,
    this.verticalPadding = 0,
    this.prefixIconPadding = EdgeInsets.zero,
    this.onChange
  });

  final TextEditingController controller;
  final String hintText;
  final bool hideLegend;
  final Widget ? legend;
  final TextInputType textInputType;
  final Widget  ? prefixIcon;
  final double fontSize;
  final double verticalPadding ;
  final EdgeInsets  prefixIconPadding;
  final ValueChanged<String> ? onChange;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  String _formatNumber(String s) => NumberFormat.decimalPattern('en').format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            widget.hideLegend ? const SizedBox.shrink() :  Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: widget.legend ?? const Text('Legend'),
            ),
            TextField(
              controller: widget.controller,
              onChanged: widget.textInputType == TextInputType.number ? (string) {
                string = _formatNumber(string.replaceAll(',', ''));
                widget.controller.value = TextEditingValue(
                  text: string,
                  selection: TextSelection.collapsed(offset: string.length),
                );
              } : widget.onChange,
              cursorColor: Theme.of(context).colorScheme.secondary,
              keyboardType: widget.textInputType,
              style: TextStyle(
                  fontSize: widget.fontSize,
                  height: 0.9
              ),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: widget.prefixIconPadding,
                  child: widget.prefixIcon ?? const SizedBox.shrink()
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: widget.fontSize,
                  color: colorTextLabel,
                ),
                isDense: true,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0, minHeight: 0
                ),
              ),
            ),
          ],
        )
    );
  }
}
