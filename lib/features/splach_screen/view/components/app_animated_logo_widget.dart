import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';

class AppAnimatedLogoWidget extends StatelessWidget {
  const AppAnimatedLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          AppStrings.translate("appName"),
          textStyle: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "normal",
            shadows: [
              Shadow(
                blurRadius: 30.0,
                color: AppColors.successColor,
                offset: Offset(0, 0),
              ),
            ],
          ),
          duration: AppDurations.longDuration,
        ),
      ],
      isRepeatingAnimation: false,
    );
  }
}
