import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.dark(primary: AppColors.primaryColor),
  brightness: Brightness.dark,
  fontFamily: 'SemiBoldCairo',
  textTheme: const TextTheme().apply(
    bodyColor: Colors.grey,
    displayColor: Colors.grey,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontFamily: 'Cairo',
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 23,
    ),
    shape: Border(
      bottom: BorderSide(color: AppColors.primaryColor),
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.primaryColor,
    shape: LinearBorder(),
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
