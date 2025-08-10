import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';

class PostPrayerAdhkarController {
  final ValueNotifier<void> notifier = ValueNotifier(null);

  double progress = 0;

  void dispose() => notifier.dispose();

  void drawCircle(BuildContext context) {
    progress += 1;
    notifier.value = null;

    if (progress >= 100) {
      Navigator.pop(context);
    }
  }

  String get getText {
    if (progress < 33) return AppStrings.translate("adhkarList")[0];
    if (progress < 66) return AppStrings.translate("adhkarList")[1];
    if (progress < 99) return AppStrings.translate("adhkarList")[2];
    return AppStrings.translate("adhkarList")[3];
  }
}
