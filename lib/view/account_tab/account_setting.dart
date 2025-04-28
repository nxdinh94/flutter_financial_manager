import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/view/account_tab/widgets/account_banner.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = AuthViewModel();
    String refreshToken = AuthManager.getRefreshToken();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Setting'),
        leading: const CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            const AccountBanner(),
            const SizedBox(height: 20,),
            AccountSettingOption(
              title: 'Change password',
              callback: (){
                context.push(FinalRoutes.changePasswordPath);
              },
              titleColor: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 5),
            AccountSettingOption(
              title: 'Sign out',
              callback: (){
                Map<String, dynamic> data = {
                  'refreshToken': refreshToken
                };
                authViewModel.logoutApi(data, context);
              },
              titleColor: emergencyColor,
            ),
            const SizedBox(height: 5),
            AccountSettingOption(
              title: 'Delete account',
              callback: (){},
              titleColor: emergencyColor,
            ),


          ],
        ),
      )
    );
  }
}

class AccountSettingOption extends StatelessWidget {
  const AccountSettingOption({super.key, required this.title, required this.callback, required this.titleColor});
  final String title;
  final VoidCallback callback;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      child: TextButton(
          onPressed: callback,
          child: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: normal
            ),
          )
      ),
    );
  }
}

