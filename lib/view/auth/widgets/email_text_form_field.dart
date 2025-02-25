import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          fontSize: normal
      ),
      decoration: const InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(
            color: colorTextLabel
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent
            )
        ),
      ),
    );
  }
}
