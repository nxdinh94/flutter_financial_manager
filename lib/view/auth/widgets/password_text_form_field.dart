import 'package:fe_financial_manager/constants/colors.dart';
import 'package:flutter/material.dart';
class PasswordTextFormField extends StatelessWidget {
  PasswordTextFormField({
    super.key, required this.isSecurePass,
    required this.passwordController,
    required this.callback,
    this.hiddenIcon = false, required this.hintText,

  });
  final bool isSecurePass;
  final TextEditingController passwordController;
  final VoidCallback callback;
  final String hintText;
  bool hiddenIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: isSecurePass,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: hiddenIcon ? const SizedBox.shrink(): InkWell(
              onTap: callback,
              child: Icon(isSecurePass
                  ? Icons.visibility_off
                  : Icons.visibility,
                  color: IconTheme.of(context).color
              )
          ),
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
          )
      ),
    );
  }
}
