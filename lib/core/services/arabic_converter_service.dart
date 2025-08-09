import 'package:intl/intl.dart';

abstract class BaseArabicConverterService {
  String convertToArabicDigits(int number);
  String convertTimeToArabic(String time);
}

class ArabicConverterServiceImpl extends BaseArabicConverterService {
  final Map<String, String> _westernToEastern = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  @override
  String convertToArabicDigits(int number) {
    return number
        .toString()
        .split('')
        .map((char) => _westernToEastern[char] ?? char)
        .join();
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
