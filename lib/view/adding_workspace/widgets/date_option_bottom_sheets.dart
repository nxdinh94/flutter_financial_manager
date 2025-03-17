import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
                      String currentDate = getCurrentDayMonthYear();
                      setPickedDate(currentDate);
                      Navigator.pop(context);
                    },
                    title: 'Today'
                  ),
                  MyDivider(),
                  TextContainer(
                    callback: ()async{
                      String currentDate = getYesterdayOfCurrentDayMonthYear();
                      setPickedDate(currentDate);
                      Navigator.pop(context);
                    },
                    title: 'Yesterday',
                  ),
                  MyDivider(),
                  TextContainer(
                    title: 'Custom',
                    callback: ()async{
                      DateTime ? newDateTime = await showRoundedDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                        borderRadius: 16,
                        height: 260,
                        styleDatePicker: MaterialRoundedDatePickerStyle(
                          backgroundHeader: Theme.of(context).colorScheme.secondary,
                          decorationDateSelected: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          textStyleDayOnCalendarSelected: TextStyle(
                            color: Theme.of(context).colorScheme.primary
                          )
                        ),
                      );
                      if(newDateTime != null){
                        String pickedDate = DateFormat('yyyy-MM-dd').format(newDateTime);
                        setPickedDate(pickedDate);
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
Future<void> _showCustomDatePicker(BuildContext context) async {
  DateTime? selectedDate = await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6, // 60% of screen height
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                  onDateChanged: (DateTime newDate) {
                    Navigator.pop(context, newDate);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  if (selectedDate != null) {
    print("Selected Date: $selectedDate");
  }
}
