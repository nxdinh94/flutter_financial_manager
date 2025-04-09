import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/text_container.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/wallet_view_model.dart';


Future showOptionBottomSheet(BuildContext context, PickedIconModel pickedWallet){
  return showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Padding(
      padding: defaultHalfPadding,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: defaultHalfPadding,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Transfer feature
                  MyListTitle(
                    leading: SvgContainer(
                      iconWidth: 30,
                      iconPath: Assets.svgTransfer,
                    ),
                    title: 'Transfer',
                    titleTextStyle: Theme.of(context).textTheme.labelLarge!,
                    hideTrailing: false,
                    leftContentPadding: 0,
                    callback: (){

                    }

                  ),
                  MyDivider(),
                  // Delete Wallet feature
                  MyListTitle(
                    callback: ()async{
                      await context.read<WalletViewModel>().deleteWallet(pickedWallet.id);
                      Navigator.pop(context);
                      await context.read<WalletViewModel>().getAllWallet();
                    },
                    leading: SvgContainer(
                      iconWidth: 22,
                      iconPath: Assets.svgTrash,
                    ),
                    title: 'Delete',
                    titleTextStyle: Theme.of(context).textTheme.labelLarge!,
                    hideTrailing: false,
                    leftContentPadding: 0,

                  ),
                  MyDivider(),
                  // Adjust balance feature
                  MyListTitle(
                    callback: (){

                    },
                    leading: SvgContainer(
                      iconWidth: 22,
                      iconPath: Assets.svgAdjustHorizontal,
                    ),
                    title: 'Adjust balance',

                    titleTextStyle: Theme.of(context).textTheme.labelLarge!,
                    hideTrailing: false,
                    leftContentPadding: 0,

                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            TextContainer(
              callback: ()async{
                Navigator.pop(context);
              },
              title: 'Cancel',
              isFontWeightBold: true,
              boxDecoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
            )
          ],
        ),
      ),
    ),
  );
}
