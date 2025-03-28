import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

const double appBarBorderRadius = 50.0;
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: TextStyle(
          color: AppColors.secondryColor,
          fontWeight: FontWeight.bold,
          fontSize: 23),
      iconTheme: IconThemeData(color: AppColors.purple),
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(appBarBorderRadius),
              bottomRight: Radius.circular(appBarBorderRadius)))),
);
