import 'package:intl/intl.dart';

class DateTimeHelper {
  //YYYY-MM-DD
  static String convertDateTimeToString(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatted;
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
