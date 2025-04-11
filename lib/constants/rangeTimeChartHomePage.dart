
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:intl/intl.dart';


String getCurrentDay(){
  String result = '';
  DateTime now = DateTime.now();
  result = DateFormat('dd-MM-yyyy').format(now);
  return '$result/$result';
}

String getThisWeek(){
  String result = '';
  //get current datetime
  DateTime now = DateTime.now();
  DateTime startOfTheWeek = now.subtract(Duration(days: now.weekday -1 ));
  DateTime endOfTheWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

  String parseStartOfTheWeek =DateTimeHelper.formatToDoubleDigitDate(
      DateFormat('dd-MM-yyyy').format(startOfTheWeek));
  String parseEndOfTheWeek = DateTimeHelper.formatToDoubleDigitDate(
      DateFormat('dd-MM-yyyy').format(endOfTheWeek));

  result = '$parseStartOfTheWeek/$parseEndOfTheWeek';
  return result;
}


String getThisMonth(){
  String result = '';
  DateTime now = DateTime.now();
  int thisMonth = now.month;
  int thisYear = now.year;
  String dayOne = '01';
  int numberOfDayOfMonth = DateTime(thisYear, thisMonth + 1, 0).day;
  String startDayOfMonth = DateTimeHelper.formatToDoubleDigitDate('$dayOne-$thisMonth-$thisYear');
  String endDayOfMonth = DateTimeHelper.formatToDoubleDigitDate('$numberOfDayOfMonth-$thisMonth-$thisYear');
  result = '$startDayOfMonth/$endDayOfMonth';
  return result;
}

String getThisYear(){
  String result = '';
  DateTime now = DateTime.now();
  int thisYear = now.year;
  String firstDay = '01';
  String firstMonth = '01';
  String numberDayOfEndYear = '31';
  String startDayOfYear = DateTimeHelper.formatToDoubleDigitDate('$firstDay-$firstMonth-$thisYear');
  String endDayOfYear = DateTimeHelper.formatToDoubleDigitDate('$numberDayOfEndYear-12-$thisYear');
  result = '$startDayOfYear/$endDayOfYear';
  return result;
}

List<Map<String, dynamic>> rangeTimeHomePageChart = [
  {'title': 'Today', 'value': getCurrentDay()},
  {'title': 'This week', 'value': getThisWeek()},
  {'title': 'This month', 'value': getThisMonth()},
  {'title': 'This year', 'value': getThisYear()},
  {'title': 'All the time', 'value': '~/~'},
];

