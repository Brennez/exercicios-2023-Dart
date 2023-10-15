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

  static String dayOfWeek(String date) {
    final newDate = DateTime.parse(date);

    String dayOfWeek = DateFormat('EEEE', 'pt_BR').format(newDate);

    dayOfWeek = dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);

    return dayOfWeek;
  }

  static String abbreviatedDate(String date) {
    final newDate = DateTime.parse(date);

    String dayOfWeek = DateFormat('EE, dd/MM/yyyy', 'pt_BR').format(newDate);

    return dayOfWeek;
  }

  static String abbreviatedMonth(DateTime date) {
    String dateFormated = DateFormat('MMM', 'pt_BR').format(date);

    return dateFormated[0].toUpperCase() + dateFormated.substring(1);
  }
}
