import 'package:intl/intl.dart';

abstract class BaseArabicConverterService {
  String convertToArabicNumber(num number);
  String convertTimeToArabic(String time);
}


class ArabicConverterByIntl extends BaseArabicConverterService {
  @override
  String convertToArabicNumber(num number) {
    final NumberFormat formatter = NumberFormat.decimalPattern('ar');
    return formatter.format(number);
  }

  @override
  String convertTimeToArabic(String time) {
  try {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final dateTime = DateTime(2000, 1, 1, hour, minute);

    final formatter = DateFormat('HH:mm', 'ar'); 
    return formatter.format(dateTime);
  } catch (_) {
    return time;
  }
}

}
