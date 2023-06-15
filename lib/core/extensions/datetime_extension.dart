import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString(String format) {
    return DateFormat(format).format(this);
  }
}
