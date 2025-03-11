import 'package:intl/intl.dart';

String toVnd(double amount) {
  final NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  return formatter.format(amount);
}