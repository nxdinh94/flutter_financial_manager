import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
class DateTimeHelper {
  //YYYY-MM-DD
  static String convertDateTimeToString(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
  // yyyy-M-d => yyyy-MM-dd
  static String formatToDoubleDigitDate(String date) {
    try {
      // Parse input date
      final parts = date.split('-');
      if (parts.length != 3) return date;

      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];

      return '$day-$month-$year';
    } catch (e) {
      return date; // Trả lại như cũ nếu lỗi
    }
  }
  static String getTheFirstDayOfMonth() {
    DateTime now = DateTime.now();
    String date = '${now.year}-0${now.month}-01';
    return date;
  }

  static Future<String> showDatePicker(BuildContext context) async {
    DateTime ? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
      height: 290,
      styleDatePicker: MaterialRoundedDatePickerStyle(
          backgroundHeader: Theme.of(context).colorScheme.secondary,
          decorationDateSelected: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          textStyleDayOnCalendarSelected: TextStyle(
              color: Theme.of(context).colorScheme.primary
          ),
      ),
    );
    // Convert to isoString format
    if(newDateTime != null){
      String formattedDate = "${newDateTime.toIso8601String().split('.')[0]}Z";
      return formattedDate;
    }
    return '';
  }

  //2025-04-11T01:56:05Z
  static String convertDateTimeToIsoString(DateTime time) {
    DateTime toUtcTime = time.toUtc();
    String formattedDate = "${toUtcTime.toIso8601String().split('.')[0]}Z";
    return formattedDate;
  }

  static String getCurrentDayMonthYear() {
    DateTime now = DateTime.now();
    String formattedDate = convertDateTimeToIsoString(now);
    return formattedDate;
  }

  static String getYesterdayOfCurrentDayMonthYear() {
    DateTime now = DateTime.now().subtract(const Duration(days: 1)).toUtc();
    String formattedDate = "${now.toIso8601String().split('.')[0]}Z";
    return formattedDate;
  }

  static int dateTimeToSecondsSinceEpoch(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch / 1000).round();
  }

  static String getNameOfDay(String date) {
    int day = DateTime.parse(date).weekday;
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
