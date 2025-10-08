import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/theme/app_colors.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.dark,
    fontFamily: 'SemiBoldCairo',
    scaffoldBackgroundColor: AppColors.darkModeScaffoldBackGroundColor,
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppColors.darkModeTextColor, // لون النصوص العادية
          displayColor: AppColors.darkModeTextColor, // لون العناوين الكبيرة
          fontFamily: 'SemiBoldCairo',
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primaryColor,
    ));
