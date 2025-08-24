import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/splach_screen/view/components/app_animated_logo_widget.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      AppDurations.longDuration,
      () {
        if (context.mounted) {
          sl<GetPrayersTimesController>().getPrayersTimes(context);
          // load data and forward animation before going to home page
        }
      },
    );

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor =
        isDark ? AppColors.darkModeTextColor : AppColors.lightModeTextColor;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppAnimatedLogoWidget(textColor: textColor),
                Text(
                  'مستضيئون بنور الله',
                  textAlign: TextAlign.center,
                  style: TextStyles.bold20(context).copyWith(color: textColor),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: const GetAdaptiveLoadingWidget(),
          ),
        ],
      ),
    );
  }
}
