import 'package:flutter/material.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/view/components/primary_prayer_times_container.dart';
import 'package:test_app/features/app/presentation/view/components/remaining_time_widget.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/splash_screen.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesConstants.prayersTimePage,
                            (route) => false,
                          ),
              child: Icon(Icons.settings),
            ),
            Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('القاهره',
                      style: TextStyles.bold20(
                        context,
                      )),
                ),
                Text(
                  '${sl<GetPrayersTimesController>().timings!.hijriDay} ${sl<GetPrayersTimesController>().timings!.hijriMonthNameArabic} ${sl<GetPrayersTimesController>().timings!.hijriYear}',
                  style: TextStyle(color: AppColors.grey400),
                ),
              ],
            ),
          ],
        ),
        PrimaryPrayerTimesContainer(),
        RemainingTimeWidget(),
      ],
    );
  }
}
