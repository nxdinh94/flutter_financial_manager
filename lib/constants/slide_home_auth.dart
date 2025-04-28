import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:flutter/material.dart';

List<Widget> slideHomeAuth(BuildContext context){
  return [
    Container(
        alignment: Alignment.center,
        child: Container(
          padding: defaultPadding,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FirstSlideBenefitRow(text: 'Cut unnecessary expenses', iconPath: Assets.pngHamburger,),
              SizedBox(height: 12),
              FirstSlideBenefitRow(text: 'Grow savings rapidly', iconPath: Assets.pngSavingInterest,),
              SizedBox(height: 12),
              FirstSlideBenefitRow(text: 'All money in one place', iconPath: Assets.pngSalary,),
              SizedBox(height: 12),
              FirstSlideBenefitRow(text: 'Save time and money', iconPath: 'assets/icon_category/loan_icon/debt_collection.png',)
            ],
          ),
        )
    ),
    Container(
      alignment: Alignment.center,
      child: Container(
        padding: defaultHalfPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: verticalHalfPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total balance', style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: secondaryColor)),
                  Text('§6.787', style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: secondaryColor)),
                ],
              ),
            ),
            const MyDivider(),
            MyListTitle(
              leading: Image.asset('assets/another_icon/wallet-2.png', width: 35, height: 35),
              title: 'Cash', callback: (){},
              titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
              trailing: Text('§6.787', style: Theme.of(context).textTheme.headlineMedium!),
              leftContentPadding: 0,
              rightContentPadding: 0,
            ),
            MyListTitle(
              leading: Image.asset('assets/account_type/bank.png', width: 35, height: 35),
              title: 'Cash', callback: (){},
              titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
              trailing: Text('§6.787', style: Theme.of(context).textTheme.headlineMedium!),
              leftContentPadding: 0,
              rightContentPadding: 0,
            ),
            MyListTitle(
              leading: Image.asset('assets/account_type/money.png', width: 35, height: 35),
              title: 'Cash', callback: (){},
              titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
              trailing: Text('§6.787', style: Theme.of(context).textTheme.headlineMedium!),
              leftContentPadding: 0,
              rightContentPadding: 0,
            )
          ],
        ),
      ),
    )
  ];
}

class FirstSlideBenefitRow extends StatelessWidget {
  const FirstSlideBenefitRow({
    super.key, required this.text, required this.iconPath,
  });
  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, width: 35, height: 35),
        const SizedBox(width: 12),
        Text(text, style: Theme.of(context).textTheme.bodyLarge,),
      ],
    );
  }
}