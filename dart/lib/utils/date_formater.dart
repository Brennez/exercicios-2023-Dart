import 'package:intl/intl.dart';

class DateFormater {
  static String dayFormater(String date) {
    DateTime newDate = DateTime.parse(date);

    return newDate.day.toString();
  }

  static String hourFormater(String date) {
    DateTime newDate = DateTime.parse(date);
    // fuso horário -03:00 da data original
    Duration offset = const Duration(hours: -3);
    newDate = newDate.add(offset);

    return DateFormat('HH:mm').format(newDate);
  }
}
