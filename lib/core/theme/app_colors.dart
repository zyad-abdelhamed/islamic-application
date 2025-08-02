import 'package:flutter/material.dart';

class AppColors {
  static const Color lightModePrimaryColor = Color(0xFF1391A2);
  static const Color darkModePrimaryColor = Color(0xFF0D1B2A);
  static final Color lightModeInActiveColor =
      const Color.fromARGB(255, 156, 211, 218).withValues(alpha: .3);
  static final Color darkModeInActiveColor =
      const Color(0xFF2A3D50).withValues(alpha: .5);
  static const Color secondryColor = Color.fromARGB(255, 216, 189, 105);
  static const Color errorColor = Color.fromARGB(255, 225, 19, 88);
  static const Color inActiveErrorColor = Color.fromARGB(255, 242, 163, 190);
  static const Color successColor = Color(0xFF388E3C);
  static const Color purple = Color(0xFF39073E);
  static const Color black = Colors.black;
  static const Color inActiveBlackColor = Color.fromARGB(255, 44, 43, 43);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFA49C9C);
  static const Color grey1 = Color.fromARGB(31, 168, 166, 166);
  static const Color grey2 = Color.fromARGB(31, 134, 133, 133);
  static Color? grey400 = Colors.grey[400];
  static const Color darkModeTextColor = Color(0xFFB0BEC5);
  static const Color lightModeTextColor = Color(0xFF212121);
}
