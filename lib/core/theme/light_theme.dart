import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/core/theme/app_colors.dart';

const double appBarBorderRadius = 50.0;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
  appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: GoogleFonts.cairo(
          textStyle: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 23)),
      shape: Border(bottom: BorderSide(color: AppColors.primaryColor))),
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColors.primaryColor,
    shape: LinearBorder(),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))))),
);
