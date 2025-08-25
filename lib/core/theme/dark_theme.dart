import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/theme/app_colors.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.darkModePrimaryColor,
    colorScheme: ColorScheme.dark(primary: AppColors.darkModeTextColor),
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
        bottom: BorderSide(color: AppColors.darkModeTextColor),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
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
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[850],
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.successColor,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.errorColor,
          width: 1.5,
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
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkModePrimaryColor,
    ));
