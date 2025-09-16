import 'package:flutter/material.dart';

class AppColors {
  static const Color lightModePrimaryColor = Color(0xFF004D40);
  static const Color lightModeScaffoldBackGroundColor = Color(0xffe9f6f3);
  static const Color darkModeScaffoldBackGroundColor = Color(0xFF121212);
  static const Color darkModePrimaryColor = Color(0xFF004D40);
  static final Color lightModeInActiveColor =
      const Color(0x33004D40) // 0x80 = 128 = نصف الشفافية
      ;
  static final Color darkModeInActiveColor =
      const Color(0xB3004D40) // 0x80 = 128 = نصف الشفافية
      ;
  static const Color secondryColor = Color(0xFFD8BD69);
  static const Color secondryColorInActiveColor = Color(0x14D8BD69);
  static const Color errorColor = Color.fromARGB(255, 225, 19, 88);
  static const Color inActiveErrorColor = Color.fromARGB(255, 242, 163, 190);
  static const Color successColor = Color(0xff185a9d);
  static const Color purple = Color(0xFF39073E);
  static const Color black = Colors.black;
  static const Color inActiveBlackColor = Color.fromARGB(255, 44, 43, 43);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFA49C9C);
  static const Color grey1 = Color.fromARGB(31, 168, 166, 166);
  static const Color grey2 = Color.fromARGB(31, 134, 133, 133);
  static Color? grey400 = Colors.grey[400];
  static const Color darkModeTextColor = Color(0xFFB0BEC5);
  static const Color lightModeTextColor = Color(0xFFF5F5F5);
  static const Color darkModeSettingsPageBackgroundColor = Color(0xFF1E1E1E);
  static const Color lightModeSettingsPageBackgroundColor = Color(0xFFF2F1F6);
}
