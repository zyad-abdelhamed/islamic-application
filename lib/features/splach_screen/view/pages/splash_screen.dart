import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/app_animated_logo_widget.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<GetPrayersTimesController>()
        .getPrayersTimes(context); // load data before going to home page

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/night_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppAnimatedLogoWidget(
                  isRepeating: false,
                ),
                const SizedBox(height: 20),
                Text(
                  'مستضيئون بنور الله',
                  style: TextStyles.bold20(context).copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GetAdaptiveLoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
