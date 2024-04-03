import 'package:intl/intl.dart';

class Formatter {
  static String formatPrice(num price) {
    final numberFormat = NumberFormat("Rs #,##,###");
    return numberFormat.format(price);
  }

  static String formatDate(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }

  static String formatDateAndTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }
}
