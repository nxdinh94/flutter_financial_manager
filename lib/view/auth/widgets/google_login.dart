import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  @override
  Widget build(BuildContext context) {
    return const LoginWithGoogle();
  }
}

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()async{
        await context.read<AuthViewModel>().loginWithGoogleApi(context);
      },
      child: Container(
        padding: defaultHalfPadding,
        decoration: BoxDecoration(
          border: Border.all(color: emergencyColor),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Row(
          children: [
            SvgPicture.asset(Assets.svgGoogle, width: 24),
            const SizedBox(width: 24),
            Text('Sign in with Google', style: Theme.of(context).textTheme.titleLarge,),
          ],
        ),
      ),
    );
  }
}
