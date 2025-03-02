import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/account_tab/widgets/account_banner.dart';
import 'package:fe_financial_manager/view/account_tab/widgets/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: SvgPicture.asset('assets/svg/abc.svg', ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('More',),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            Row(
              children: [
                Text('Support', style: Theme.of(context).textTheme.titleMedium,),
                IconButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/settings');
                  },
                  icon: Icon(
                    Icons.contact_support_outlined,
                    color: IconTheme.of(context).color,
                  ),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              AccountBanner(),
              Divider(height: 0,),
              Container(
                color: Theme.of(context).colorScheme.primary,
                child: MyListTile(
                  callback: (){
                    context.push('${RoutesName.accountPath}/${RoutesName.accountSettingsPath}');
                  },
                  isSubTitle: true,
                  leadingIcon: Icons.person,
                  subTitle: 'Free account',
                  title: 'My account',
                )
              )
            ],
          ),
        )
      ),
    );

  }
}
