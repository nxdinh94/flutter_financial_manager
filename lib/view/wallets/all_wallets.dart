import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/common_widget/adding_circle.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class AllWallets extends StatefulWidget {
  const AllWallets({super.key});

  @override
  State<AllWallets> createState() => _AllWalletsState();
}

class _AllWalletsState extends State<AllWallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallets'),
        leading: CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            MyListTitle(
              callback: (){},
              title: 'Total',
              titleTextStyle: Theme.of(context).textTheme.titleLarge!,
              leading: Image.asset('assets/another_icon/global.png', width: 33,),
              subTitle: MoneyVnd(fontSize: normal, amount: 123456789, iconWidth: 12,),
              hideBottomBorder: false,
              hideTopBorder: false,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text('INCLUDED IN TOTAL', style: Theme.of(context).textTheme.labelSmall,),
            ),
            const SizedBox(height: 6),
            MyListTitle(
              callback: (){},
              title: 'Tiền mặt',
              titleTextStyle: Theme.of(context).textTheme.titleLarge!,
              leading: Image.asset('assets/another_icon/global.png', width: 33,),
              subTitle: MoneyVnd(fontSize: normal, amount: 123456789, iconWidth: 12,),
              hideTrailing: false,
              hideBottomBorder: false,
              hideTopBorder: false,            ),
              const SizedBox(height: 20),
            MyListTitle(
              callback: (){
                context.push(RoutesName.addWalletsPath);
                },
              title: 'Add wallet',
              titleTextStyle:
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: secondaryColor),
              leading: Padding(
                padding: const EdgeInsets.all(6.0),
                child: AddingCircle(),
              ),
              hideTrailing: false,
              hideTopBorder: false,
              hideBottomBorder: false,
            ),
          ],
        ),
      ),
    );
  }
}
