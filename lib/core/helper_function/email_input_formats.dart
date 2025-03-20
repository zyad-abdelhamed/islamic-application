import 'package:flutter/services.dart';

List<TextInputFormatter> get getEmailInputFormats {
  return <TextInputFormatter>[
    // FilteringTextInputFormatter.deny(RegExp(r'\s')), // منع المسافات
    FilteringTextInputFormatter.allow(
      RegExp(
          r'[a-zA-Z0-9@._-]'), // السماح فقط بالأحرف والأرقام والرموز المسموحة في البريد الإلكتروني
    ),
  ];
}
