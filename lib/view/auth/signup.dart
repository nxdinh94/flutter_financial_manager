import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view/auth/widgets/password_text_form_field.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../generated/paths.dart';
import '../../utils/routes/routes_name.dart';
import 'widgets/email_text_form_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Container(
          child: Form(
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
                      Divider(
                        height: 0,
                      ),
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
                      Divider(
                        height: 0,
                      ),
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
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String confirmPassword = _confirmPasswordController.text;
                        // if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
                        //   Utils.flushBarErrorMessage("These fields cannot be null", context);
                        //   return;
                        // }
                        // if(Utils.checkValidEmail(email)){
                        //   Utils.flushBarErrorMessage("Email is not valid", context);
                        //   return;
                        // }
                        // if(_confirmPasswordController.text != _passwordController.text){
                        //   Utils.flushBarErrorMessage("Password & Confirm Password doesn't match", context);
                        //   return;
                        // }
                        Map data = {
                          'email':'nguyenxuandinh4@gmail.com',
                          'password': 'Dinh@123',
                          'confirmPassword': 'Dinh@123',
                        };
                        authViewMode.signUpApi(data, context);
                      },
                      child: Text('Sign up', style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
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
                      ),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
