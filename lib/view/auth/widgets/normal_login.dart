import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view/auth/widgets/email_text_form_field.dart';
import 'package:fe_financial_manager/view/auth/widgets/password_text_form_field.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart' show LoadingOverlay;
import 'package:provider/provider.dart' show Consumer;

class NormalLogin extends StatefulWidget {
  const NormalLogin({super.key, required this.func});
  final Future<void> Function(Map<String, dynamic> data) func;
  @override
  State<NormalLogin> createState() => _NormalLoginState();
}

class _NormalLoginState extends State<NormalLogin> {

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController(text: 'nguyenxuandinh336@gmail.com');
  TextEditingController _passwordController = TextEditingController(text: 'Dinh@1234');
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool validateInput(){
    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      Utils.flushBarErrorMessage('Email and password cannot be empty', context);
      return false;
    }
    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
      final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailController.text);
      if(!emailValid){
        Utils.flushBarErrorMessage('Invalid email', context);
        return false;
      }
      if (_passwordController.text.length < 6) {
        Utils.flushBarErrorMessage('Please enter more than 6 digit password', context);
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {

    _emailController.dispose();
    _passwordController.dispose();
    _obsecurePassword.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                EmailTextFormField(
                    key: const ValueKey('emailTextFormField'),
                    emailController: _emailController
                ),
                const MyDivider(),
                ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return PasswordTextFormField(
                      key: const ValueKey('passwordTextFormField'),
                      isSecurePass: value,
                      passwordController: _passwordController,
                      callback: () {
                        _obsecurePassword.value = !_obsecurePassword.value;
                      },
                      hintText: 'Password',
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: const ValueKey('loginButton'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              onPressed: () async {
                bool isValid = validateInput();
                if (isValid) {
                  Map<String, dynamic> data = {
                    'email': _emailController.text.trim(),
                    'password': _passwordController.text.trim(),
                  };
                  widget.func(data);
                }
              },
              child: const Text('Sign in'),
            ),
          ),
          SizedBox(height: height * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => context.push(FinalRoutes.signUpPath),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              InkWell(
                onTap: () => context.push(FinalRoutes.forgotPasswordPath),
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
