import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/core/theme/app_colors.dart';

const double appBarBorderRadius = 50.0;
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent
  ),
  appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: GoogleFonts.cairo(textStyle: TextStyle(
          color: AppColors.secondryColor,
          fontWeight: FontWeight.bold,
          fontSize: 23)),
      iconTheme: IconThemeData(color: AppColors.purple),
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(appBarBorderRadius),
              bottomRight: Radius.circular(appBarBorderRadius)))),
);
