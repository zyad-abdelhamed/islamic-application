import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.darkModePrimaryColor,
  colorScheme: ColorScheme.dark(primary: AppColors.darkModePrimaryColor),
  brightness: Brightness.dark,
  fontFamily: 'SemiBoldCairo',
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontFamily: 'Cairo',
      color: AppColors.darkModeTextColor,
      fontWeight: FontWeight.bold,
      fontSize: 23,
    ),
    shape: Border(
      bottom: BorderSide(color: AppColors.darkModePrimaryColor),
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.darkModePrimaryColor,
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
