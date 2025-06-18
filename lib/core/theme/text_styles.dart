import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';

class TextStyles {
  static TextStyle semiBold16(
      {required BuildContext context, required Color color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveFontSize(context: context, fontSize: 16),
      height: 1.5, // 150%
    );
  }

  static TextStyle regular14_150(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: getResponsiveFontSize(context: context, fontSize: 14),
      height: 1.5, // 150%
    );
  }

  static TextStyle semiBold18(BuildContext context, Color color) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: getResponsiveFontSize(context: context, fontSize: 18),
      height: 1.5, // 150%
    );
  }

  static TextStyle bold20(BuildContext context) {
    return TextStyle(
        fontSize: getResponsiveFontSize(context: context, fontSize: 20),
        fontWeight: FontWeight.bold);
  }

  static TextStyle semiBold16_120(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveFontSize(context: context, fontSize: 16),
      height: 1.2, // 120%
    );
  }

  static TextStyle semiBold20(BuildContext context) {
    return TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveFontSize(context: context, fontSize: 20),
      height: 1.5, // 150%
    );
  }

  static TextStyle semiBold32auto(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveFontSize(context: context, fontSize: 32),
      height: null, // Auto
    );
  }

  static TextStyle semiBold32(BuildContext context, {required Color color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveFontSize(context: context, fontSize: 32),
      height: 1.5, // 150%
    );
  }

  static TextStyle semiBold32Decoreted(BuildContext context,
      {required Color color}) {
    return GoogleFonts.cairo(
        textStyle: TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: getResponsiveFontSize(context: context, fontSize: 32),
      height: 1.5, // 150%
    ));
  }

  static TextStyle regular16_120(BuildContext context, {required Color color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: getResponsiveFontSize(fontSize: 16, context: context),
      height: 1.2, // 120%
    );
  }
}
