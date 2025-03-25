import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/model/user_model.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/padding.dart';
class AccountBanner extends StatelessWidget {
  const AccountBanner({super.key});

  @override
  Widget build(BuildContext context) {

    final UserModel user = AuthManager.getUser();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: verticalPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset('assets/sampleImage/girl3.jpg', width: 80,),
          ),
          const SizedBox(height: 12),
          Text(user.name, style: Theme.of(context).textTheme.titleMedium,),
          Text(user.email, style: Theme.of(context).textTheme.labelSmall,),
          const SizedBox(height: 12),
          SvgPicture.asset(Assets.svgGoogle, width: 24)
        ],
      ),
    );
  }
}
