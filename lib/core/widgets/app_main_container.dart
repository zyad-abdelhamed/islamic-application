import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';

class AppMainContainer extends StatelessWidget {
  const AppMainContainer({
    super.key,
    required this.height,
    required this.child,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: context.isDarkMode
              ? [
                  Color(0xFF1B4D4B),
                  Color(0xFF00695C),
                ]
              : [
                  Color(0xFF4DB6AC),
                  AppColors.teal,
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
