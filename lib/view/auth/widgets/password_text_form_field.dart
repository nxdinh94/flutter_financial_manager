import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class PasswordTextFormField extends StatefulWidget {
  PasswordTextFormField({
    super.key, required this.isSecurePass,
    required this.passwordController,
    this.callback,
    this.hiddenIcon = false,
    this.clearAll = false,
    required this.hintText,


  });
  final bool isSecurePass;
  final TextEditingController passwordController;
  final VoidCallback? callback;
  final String hintText;
  bool hiddenIcon;
  bool clearAll;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isHaveText = false;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: widget.isSecurePass,
      obscuringCharacter: "*",
      cursorColor: colorTextBlack,
      onChanged: (value){
        if(value.isNotEmpty){
          setState(() {
            isHaveText = true;
          });
        }else{
          setState(() {
            isHaveText = false;
          });
        }
      },
      decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.hiddenIcon ? const SizedBox.shrink(): Container(
            // if clearAll is true, show clear icon, else show visibility icon
            child: widget.clearAll ?  InkWell(
              child: isHaveText?
                SvgContainer(iconWidth: 18, iconPath: 'assets/svg/delete.svg',) :
                const SizedBox.shrink(),
              onTap: (){
                widget.passwordController.clear();
                setState(() {
                  isHaveText = false;
                });
              },
            ):
            InkWell(
              onTap: widget.callback,
              child: Icon(widget.isSecurePass
                ? Icons.visibility_off
                : Icons.visibility,
                color: IconTheme.of(context).color
              )
            ),
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
