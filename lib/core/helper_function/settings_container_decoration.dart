import 'package:flutter/material.dart';

BoxDecoration settengsContainerBoxDecoration(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  const double borderRadius = 15.0;

  return BoxDecoration(
    color: isDark ? Colors.grey[850] : Colors.white,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: getAppBoxShadow(context),
  );
}

List<BoxShadow> getAppBoxShadow(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  if (isDark) {
    return [
      BoxShadow(
        color: Colors.grey.shade900.withAlpha(179), // 0.7 * 255 = 178.5 ~ 179
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(0, 3),
      ),
      BoxShadow(
        color: Colors.grey.withAlpha(51), // 0.2 * 255 = 51
        blurRadius: 4,
        spreadRadius: 0,
        offset: const Offset(0, -1),
      ),
    ];
  } else {
    return [
      BoxShadow(
        color: Colors.grey.withAlpha(77), // 0.3 * 255 = 76.5 ~ 77
        blurRadius: 3,
        spreadRadius: 1,
        offset: const Offset(0, 3),
      ),
    ];
  }
}
