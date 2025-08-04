import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

const double appBarBorderRadius = 50.0;

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.lightModePrimaryColor,
  colorScheme: ColorScheme.light(primary: AppColors.lightModePrimaryColor),
  fontFamily: 'SemiBoldCairo',
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontFamily: 'Cairo',
      color: AppColors.lightModePrimaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 23,
    ),
    shape: Border(
      bottom: BorderSide(color: AppColors.lightModePrimaryColor),
    ),
    iconTheme: IconThemeData(color: Colors.grey),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.lightModePrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    ),
  ),
);
