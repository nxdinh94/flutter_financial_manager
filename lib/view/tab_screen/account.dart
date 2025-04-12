import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/account_tab/widgets/account_banner.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  Future<void> onCategoryItemTap ( PickedIconModel value) async {
    context.push(
        FinalRoutes.editCategoryPath,
        extra: {
          'pickedCategory' : value
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('accountTab'),
      appBar: AppBar(
        title: const Text('More',),
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
            MyListTitle(
              title: 'My account',
              callback: (){
                context.push(FinalRoutes.accountSettingsPath);
              },
              leading: SvgContainer(
                iconWidth: 28,
                iconPath: Assets.svgPerson,
              ),
              subTitle: const Text('Free account'),
              leftContentPadding: 12,
              hideBottomBorder: false,
            ),
            const SizedBox(height: 30,),
            MyListTitle(
              title: 'Categories',
              callback: (){
                context.push(
                  FinalRoutes.allCategoryPath,
                  extra: {
                    'onTap' : onCategoryItemTap
                  }
                );
              },
              leading: SvgContainer(
                iconWidth: 30,
                iconPath: Assets.svgCategory
              ),
              leftContentPadding: 12,
              hideTopBorder: false,
              hideBottomBorder: false,
            ),
            MyListTitle(
              title: 'Events',
              callback: (){
                context.push(FinalRoutes.eventPath);
              },
              leading: SvgContainer(
                iconWidth: 30,
                iconPath: Assets.svgWallet
              ),
              leftContentPadding: 12,
              hideBottomBorder: false,
            )
          ],
        ),
      )
    );

  }
}
