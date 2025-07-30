import 'package:flutter/material.dart';
import 'package:test_app/core/theme/theme_provider.dart';

class AppColors {
  static Color primaryColor(BuildContext context) =>
      ThemeCubit.controller(context).state
          ? darkModePrimaryColor
          : lightModePrimaryColor;
  static const Color lightModePrimaryColor = Color(0xFF1391A2);
  static const Color darkModePrimaryColor = Color(0xFF263238);
  static Color inActivePrimaryColor =
      Color.fromARGB(255, 156, 211, 218).withValues(alpha: .3);
  static const Color secondryColor = Color.fromARGB(255, 216, 189, 105);
  static const Color thirdColor = Color.fromARGB(255, 225, 19, 88);
  static const Color inActiveThirdColor = Color.fromARGB(255, 242, 163, 190);
  static const Color purple = Color(0xFF39073E);
  static const Color black = Colors.black;
  static const Color inActiveBlackColor = Color.fromARGB(255, 44, 43, 43);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFA49C9C);
  static const Color grey1 = Color.fromARGB(31, 168, 166, 166);
  static const Color grey2 = Color.fromARGB(31, 134, 133, 133);
  static Color? grey400 = Colors.grey[400];
  static const Color blueGrey800 = Color(0XFF37474F);
}
