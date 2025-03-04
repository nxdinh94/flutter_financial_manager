import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'text_container.dart';


Future showDateOptionBottomSheet(BuildContext context){
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
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextContainer(
                    callback: (){},
                    title: 'Today'
                  ),
                  MyDivider(),
                  TextContainer(
                    callback: (){},
                    title: 'Yesterday',
                  ),
                  MyDivider(),
                  TextContainer(
                    title: 'Custom',
                    callback: (){},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            TextContainer(
              callback: (){
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