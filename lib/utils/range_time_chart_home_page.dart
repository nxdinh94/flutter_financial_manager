
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:intl/intl.dart';


String getCurrentDay(){
  String result = '';
  DateTime now = DateTime.now();
  result = DateFormat('dd-MM-yyyy').format(now);
  return '$result/$result';
}

String getYesterday(){
  String result = '';
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));
  result = DateFormat('dd-MM-yyyy').format(yesterday);
  return '$result/$result';
}

String getLastWeek() {
  String result = '';
  DateTime now = DateTime.now();

  // Tính ngày đầu tuần hiện tại
  DateTime startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));

  // Ngày đầu tuần trước = đầu tuần hiện tại - 7 ngày
  DateTime startOfLastWeek = startOfThisWeek.subtract(const Duration(days: 7));

  // Ngày cuối tuần trước = startOfLastWeek + 6 ngày
  DateTime endOfLastWeek = startOfLastWeek.add(const Duration(days: 6));

  String parseStartOfLastWeek = DateTimeHelper.formatToDoubleDigitDate(
      DateFormat('dd-MM-yyyy').format(startOfLastWeek));
  String parseEndOfLastWeek = DateTimeHelper.formatToDoubleDigitDate(
      DateFormat('dd-MM-yyyy').format(endOfLastWeek));

  result = '$parseStartOfLastWeek/$parseEndOfLastWeek';
  return result;
}


// get this week
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

String getLastMonth() {
  String result = '';

  DateTime now = DateTime.now();

  // Lùi về tháng trước
  DateTime startOfLastMonth = DateTime(now.year, now.month - 1, 1);

  // Ngày cuối tháng trước = ngày 0 của tháng hiện tại
  DateTime endOfLastMonth = DateTime(now.year, now.month, 0);

  String parseStartOfLastMonth = DateTimeHelper.formatToDoubleDigitDate(
      DateFormat('dd-MM-yyyy').format(startOfLastMonth));
  String parseEndOfLastMonth = DateTimeHelper.formatToDoubleDigitDate(
      DateFormat('dd-MM-yyyy').format(endOfLastMonth));

  result = '$parseStartOfLastMonth/$parseEndOfLastMonth';
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

String getThisQuarter(){
  String result = '';
  DateTime now = DateTime.now();
  int thisMonth = now.month;
  int year = now.year;

  switch(thisMonth){
    case >=1 && <=3:
      result = '$year-01-01/$year-03-31';
      break;
    case >=4 && <=6:
      result = '$year-04-01/$year-06-30';
      break;
    case >=7 && <=9:
      result = '$year-07-01/$year-09-30';
      break;
    case >=10 && <=12:
      result = '$year-10-01/$year-12-31';
      break;
  }
  return result;
}
List<String> getAllQuartersOfYear() {
  int year = DateTime.now().year;
  List<String> quarters = [];

  List<DateTime> startDates = [
    DateTime(year, 1, 1),   // Q1 start
    DateTime(year, 4, 1),   // Q2 start
    DateTime(year, 7, 1),   // Q3 start
    DateTime(year, 10, 1),  // Q4 start
  ];

  List<DateTime> endDates = [
    DateTime(year, 3, 31),  // Q1 end
    DateTime(year, 6, 30),  // Q2 end
    DateTime(year, 9, 30),  // Q3 end
    DateTime(year, 12, 31), // Q4 end
  ];

  for (int i = 0; i < 4; i++) {
    String start = DateTimeHelper.formatToDoubleDigitDate(
        DateFormat('dd-MM-yyyy').format(startDates[i]));
    String end = DateTimeHelper.formatToDoubleDigitDate(
        DateFormat('dd-MM-yyyy').format(endDates[i]));
    quarters.add('$start/$end');
  }

  return quarters;
}



List<Map<String, dynamic>> rangeTimeHomePageChart = [
  {'title': 'Today', 'value': getCurrentDay()},
  {'title': 'This week', 'value': getThisWeek()},
  {'title': 'This month', 'value': getThisMonth()},
  {'title': 'This quarter', 'value': getThisQuarter()},
  {'title': 'All the time', 'value': '~/~'},
];

