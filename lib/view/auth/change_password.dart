import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/view/auth/widgets/email_text_form_field.dart';
import 'package:fe_financial_manager/view/auth/widgets/password_text_form_field.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_float_action_button.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  void initState() {
    emailController.text = AuthManager.getUser().email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        leading: const CustomBackNavbar(),
      ),
      floatingActionButton: MyFloatActionButton(
        callback: (){
          String oldPassword = oldPasswordController.text;
          String newPassword = newPasswordController.text;
          String confirmPassword = confirmPasswordController.text;
          Map<String, String> data = {
            'oldPassword': oldPassword,
            'newPassword': newPassword,
            'confirmNewPassword': confirmPassword,
          };
          if(oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty){
            Utils.flushBarErrorMessage('All fields are required', context);
            return;
          }
          if(newPassword != confirmPassword){
            Utils.flushBarErrorMessage('Password does not match', context);
            return;
          }
          _authViewModel.changePasswordApi(data, context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            MyDivider(),
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: EmailTextFormField(
                emailController: emailController,
                readOnly: true,
              ),
            ),
            MyDivider(),
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: PasswordTextFormField(
                isSecurePass: true,
                passwordController: oldPasswordController,
                hintText: 'Old Password',
                clearAll: true,
              ),
            ),
            MyDivider(),
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: PasswordTextFormField(
                isSecurePass: true,
                passwordController: newPasswordController,
                hintText: 'New Password',
                clearAll: true,
              ),
            ),
            MyDivider(),
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: PasswordTextFormField(
                isSecurePass: true,
                passwordController: confirmPasswordController,
                hintText: 'Confirm Password',
                clearAll: true,
              ),
            ),
            MyDivider(),
            const SizedBox(height: 40,),
            MyDivider(),
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              child: TextButton(
                onPressed: (){},
                child: Text('Forgot Password?', style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
