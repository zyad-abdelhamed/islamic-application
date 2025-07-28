import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

const double appBarBorderRadius = 50.0;

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
 fontFamily: 'SemiBoldCairo', 
  textTheme: const TextTheme().apply(
  //  fontFamily: 'Cairo',
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
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
