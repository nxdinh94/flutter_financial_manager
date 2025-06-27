import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view/auth/widgets/google_login.dart';
import 'package:fe_financial_manager/view/auth/widgets/password_text_form_field.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../generated/paths.dart';
import 'widgets/email_text_form_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController(text: 'nguyenxuandinh336@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'Dinh@1234');
  final TextEditingController _confirmPasswordController = TextEditingController(text: 'Dinh@1234');

  late String email;
  late String password;
  late String confirmPassword;

  bool validate (){
    print(email);
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      Utils.flushBarErrorMessage("These fields cannot be null", context);
      return false;
    }
    if(!Utils.checkValidEmail(email)){
      Utils.flushBarErrorMessage("Email is not valid", context);
      return false;
    }
    if(_confirmPasswordController.text != _passwordController.text){
      Utils.flushBarErrorMessage("Password & Confirm Password doesn't match", context);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    email = _emailController.text;
    password = _passwordController.text;
    confirmPassword = _confirmPasswordController.text;
  }
  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obsecurePassword.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: const ValueKey('signUp'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: const CustomBackNavbar(),
        title: const Text('Sign up'),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: 300
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                const LoginWithGoogle(),
                Padding(
                  padding: verticalPadding,
                  child: Row(
                    children: [
                      const Expanded(child: MyDivider()),
                      Padding(
                        padding: horizontalPadding,
                        child: Text('OR', style: Theme.of(context).textTheme.labelLarge,),
                      ),
                      const Expanded(child: MyDivider()),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            EmailTextFormField(emailController: _emailController),
                            const MyDivider(),
                            ValueListenableBuilder(
                              valueListenable: _obsecurePassword,
                              builder: (context, value, child) {
                                return PasswordTextFormField(
                                  isSecurePass: _obsecurePassword.value,
                                  passwordController: _passwordController,
                                  hintText: 'Password',
                                  callback: () {
                                    _obsecurePassword.value =
                                    !_obsecurePassword.value;
                                  },
                                );
                              }
                            ),
                            const MyDivider(),
                            ValueListenableBuilder(
                              valueListenable: _obsecurePassword,
                              builder: (context, value, child) {
                                return PasswordTextFormField(
                                  isSecurePass: _obsecurePassword.value,
                                  passwordController: _confirmPasswordController,
                                  hintText: 'Confirm password',
                                  callback: () {
                                    _obsecurePassword.value =
                                    !_obsecurePassword.value;
                                  },
                                  hiddenIcon: true,
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            )
                          ),
                          onPressed: () {
                            bool isValidated = validate();
                            if(isValidated){
                              Map data = {
                                'email': _emailController.text.trim(),
                                'password': _passwordController.text.trim(),
                                'confirmPassword': _confirmPasswordController.text.trim(),
                              };
                              authViewMode.signUpApi(data, context);
                            }
                          },
                          child: const Text('Sign up')
                        ),
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              context.push(FinalRoutes.signInPath);
                            },
                            child: Text("Sign in", style: TextStyle(
                                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                                color: Theme.of(context).colorScheme.secondary
                            )
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
