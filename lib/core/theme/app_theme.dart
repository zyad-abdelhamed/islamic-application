import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/theme/app_colors.dart';

class AppTheme {
  // ================= Common =================

  static final ThemeData _common = ThemeData(
    primaryColor: AppColors.primaryColor,
    fontFamily: 'SemiBoldCairo',
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
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ConstantsValues.cardBorderRadius),
          bottomLeft: Radius.circular(ConstantsValues.cardBorderRadius),
        ),
      ),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 6,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      activeTrackColor: AppColors.primaryColor,
      inactiveTrackColor: AppColors.primaryColor.withAlpha(50),
      thumbColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ConstantsValues.fullCircularRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ConstantsValues.fullCircularRadius),
        borderSide: const BorderSide(
          color: AppColors.successColor,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ConstantsValues.fullCircularRadius),
        borderSide: const BorderSide(
          color: AppColors.errorColor,
          width: 1.5,
        ),
      ),
    ),
  );

  // ================= Light Theme =================

  static final ThemeData light = _common.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightModeScaffoldBackGroundColor,
    appBarTheme: _common.appBarTheme.copyWith(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    inputDecorationTheme: _common.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );

  // ================= Dark Theme =================

  static final ThemeData dark = _common.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkModeScaffoldBackGroundColor,
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppColors.darkModeTextColor,
          displayColor: AppColors.darkModeTextColor,
          fontFamily: 'SemiBoldCairo',
        ),
    appBarTheme: _common.appBarTheme.copyWith(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: _common.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: Colors.black,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
