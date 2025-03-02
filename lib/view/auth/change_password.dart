import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/respository/auth_repository.dart';
import 'package:fe_financial_manager/view/auth/widgets/email_text_form_field.dart';
import 'package:fe_financial_manager/view/auth/widgets/password_text_form_field.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController(text: 'abd@gmail.com');
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        leading: CustomBackNavbar(),
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
            MyDivider(),
            const SizedBox(height: 10,),
            Padding(
              padding: horizontalPadding,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: (){
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
                  child: const Text('Save', style: TextStyle(
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
