// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_local_variable, avoid_print

import 'package:fe_financial_manager/view/auth/widgets/email_text_form_field.dart';
import 'package:fe_financial_manager/view/auth/widgets/password_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../res/widgets/round_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/auth_view_model.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
    ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();


    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();

      _emailController.dispose();
      _passwordController.dispose();
      _obsecurePassword.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                            callback: () {
                              _obsecurePassword.value =
                              !_obsecurePassword.value;
                            },
                            hintText: 'Password',
                          );
                        }),
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
                     // if (_emailController.text.isEmpty) {
                     //   Utils.flushBarErrorMessage('Please enter email', context);
                     // } else if (_passwordController.text.isEmpty) {
                     //   Utils.flushBarErrorMessage(
                     //       'Please enter password', context);
                     // } else if (_passwordController.text.length < 6) {
                     //   Utils.flushBarErrorMessage(
                     //       'Please enter 6 digit password', context);
                     // } else {
                     // Map data = {
                     //   'email': _emailController.text.toString(),
                     //   'password': _passwordController.text.toString(),
                     // };
                     Map data = {
                       'email':'nguyenxuandinh336@gmail.com',
                       'password': 'Dinh@123',
                     };
                     // Validate returns true if the form is valid, or false otherwise.
                     // if (_formKey.currentState!.validate()) {
                     //   context.push('${RoutesName.homeAuthPath}/${RoutesName.signUpPath}');
                     // }
                     authViewMode.loginApi(data, context);
                     print('api hit');
                     // }
                    },
                    child: Text('Sign in', style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  )
                 ),
               ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          context.push('${RoutesName.homeAuthPath}/${RoutesName.signUpPath}');
                        },
                        child: Text("Sign Up", style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                            color: Theme.of(context).colorScheme.secondary
                        )
                    ),),

                    InkWell(
                        onTap: () {
                          context.push('${RoutesName.homeAuthPath}/${RoutesName.forgotPasswordPath}');
                        },
                        child: Text("Forgot password?", style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                          color: Theme.of(context).colorScheme.secondary
                        ))
                    ),
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