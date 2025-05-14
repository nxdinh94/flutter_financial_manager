// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_local_variable, avoid_print

import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/utils/sign_in_with_google.dart';
import 'package:fe_financial_manager/view/auth/widgets/email_text_form_field.dart';
import 'package:fe_financial_manager/view/auth/widgets/google_login.dart';
import 'package:fe_financial_manager/view/auth/widgets/normal_login.dart';
import 'package:fe_financial_manager/view/auth/widgets/password_text_form_field.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {


    @override
    Widget build(BuildContext context) {

      return Consumer<AuthViewModel>(
        builder: (context, auth, child) {
          return LoadingOverlay(
            isLoading: auth.loading,
            child: Scaffold(
              key: const ValueKey('signIn'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              appBar: AppBar(
                title: Text('Sign In'),
                leading: CustomBackNavbar(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 300
                      ),
                      child: LoginWithGoogle()
                    ),
                    Padding(
                      padding: verticalPadding,
                      child: Row(
                        children: [
                          Expanded(child: MyDivider()),
                          Padding(
                            padding: horizontalPadding,
                            child: Text('OR', style: Theme.of(context).textTheme.labelLarge,),
                          ),
                          Expanded(child: MyDivider()),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: 300
                      ),
                      child: NormalLogin(
                        func: (Map<String, dynamic> data)async{
                          await auth.loginApi(data, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

}