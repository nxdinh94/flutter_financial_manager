import 'package:intl/intl.dart';


class FormatNumber {
  // 1234 -> 1,234
  static String format(String s){
    return NumberFormat.decimalPattern('en').format(int.parse(s));
  }

  // remove all colon in string
  static String cleanedNumber(String value) {
    return value.replaceAll(',', '');
  }

}