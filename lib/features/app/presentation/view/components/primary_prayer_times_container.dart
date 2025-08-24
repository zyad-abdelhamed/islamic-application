import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/primary_prayer_times_container_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_inner_container.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget_background_image.dart';

class PrimaryPrayerTimesContainer extends StatelessWidget {
  const PrimaryPrayerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final PrimaryPrayerTimesContainerController controller1 =
        PrimaryPrayerTimesContainerController.instance;
    final controller = sl<GetPrayersTimesController>();
    final timings = controller.timings;

    final List<String> prayerTimes = [
      timings.fajrArabic,
      timings.sunriseArabic,
      timings.dhuhrArabic,
      timings.asrArabic,
      timings.maghribArabic,
      timings.ishaArabic,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.only(top: 10.0),
      decoration:
          controller1.boxDecoration(color: Theme.of(context).primaryColor),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PrayerTimesWidgetBackgroundImage(),
          ),
          Column(
            children: <Widget>[
              // صف أوقات الصلاة
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: ValueListenableBuilder<NextPrayer>(
                    valueListenable:
                        context.read<NextPrayerController>().nextPrayerNotifier,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          prayerTimes.length,
                          (index) => Expanded(
                            child: AnimatedContainer(
                              duration: AppDurations.longDuration,
                              decoration: controller1.highlightBoxDecoration(
                                  context, index),
                              child: Text(
                                prayerTimes[index],
                                textAlign: TextAlign.center,
                                style: controller1.dataTextStyle,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              // الحاوية الداخلية
              PrayerTimesInnerContainer(),
            ],
          ),
        ],
      ),
    );
  }
}
