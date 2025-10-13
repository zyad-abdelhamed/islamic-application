import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

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
          colors: Theme.of(context).brightness == Brightness.dark
              ? [Color(0xFF2A7BAE), Color(0xFF3B8E75)]
              : [const Color(0xFF4CC8F4), const Color(0xFF6AD6B9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
