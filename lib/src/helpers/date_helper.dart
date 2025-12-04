import 'package:intl/intl.dart';

String formatDateStringDDMMMYYYY(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);

    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);

    return formattedDate;
  } catch (e) {
    return 'Invalid date';
  }
}
