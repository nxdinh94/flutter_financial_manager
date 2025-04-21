import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'text_container.dart';


Future showDateOptionBottomSheet(BuildContext context, Function setPickedDate){
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
                    callback: ()async{
                      String currentDate = DateTimeHelper.getCurrentDayMonthYear();
                      setPickedDate(currentDate);
                      Navigator.pop(context);
                    },
                    title: 'Today'
                  ),
                  MyDivider(),
                  TextContainer(
                    callback: ()async{
                      String currentDate = DateTimeHelper.getYesterdayOfCurrentDayMonthYear();
                      setPickedDate(currentDate);
                      Navigator.pop(context);
                    },
                    title: 'Yesterday',
                  ),
                  MyDivider(),
                  TextContainer(
                    title: 'Custom',
                    callback: ()async{
                      String result = await DateTimeHelper.showDatePicker(context);
                      if(result.isNotEmpty){
                        setPickedDate(result);
                        Navigator.pop(context);
                      }
                    },
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
