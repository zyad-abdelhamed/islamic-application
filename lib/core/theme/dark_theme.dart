import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/light_theme.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
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