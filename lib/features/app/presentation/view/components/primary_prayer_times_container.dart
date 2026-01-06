import 'package:flutter/material.dart';
import 'package:test_app/core/widgets/app_main_container.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_inner_container.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget_background_image.dart';

class PrimaryPrayerTimesContainer extends StatelessWidget {
  const PrimaryPrayerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainContainer(
      height: 200.0,
      margine: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PrayerTimesWidgetBackgroundImage(),
          ),
          const PrayerTimesInnerContainer(),
        ],
      ),
    );
  }
}
