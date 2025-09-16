import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/primary_prayer_times_container_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/next_prayer_controller.dart';
import 'package:test_app/features/app/presentation/view/components/next_prayer_widget.dart';

class PrayerTimesInnerContainer extends StatelessWidget {
  const PrayerTimesInnerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final PrimaryPrayerTimesContainerController controller =
        PrimaryPrayerTimesContainerController.instance;

    final timings = sl<GetPrayersTimesController>().timings;

    final List<String> prayerTimes = [
      timings.fajrArabic,
      timings.sunriseArabic,
      timings.dhuhrArabic,
      timings.asrArabic,
      timings.maghribArabic,
      timings.ishaArabic,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder(
              valueListenable:
                  context.read<NextPrayerController>().nextPrayerNotifier,
              builder: (context, NextPrayer value, child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        controller.names.length,
                        (index) => Expanded(
                              child: AnimatedContainer(
                                duration: AppDurations.longDuration,
                                decoration: controller.highlightBoxDecoration(
                                    context, index),
                                child: DataColumn(
                                    index: index,
                                    prayerTimes: prayerTimes,
                                    controller: controller),
                              ),
                            )));
              }),
          const Spacer(),
          // الصلاة القادمة
          const NextPrayerWidget(),
        ],
      ),
    );
  }
}

class DataColumn extends StatelessWidget {
  const DataColumn({
    super.key,
    required this.index,
    required this.prayerTimes,
    required this.controller,
  });

  final int index;
  final List<String> prayerTimes;
  final PrimaryPrayerTimesContainerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          prayerTimes[index],
          textAlign: TextAlign.center,
          style: controller.dataTextStyle(context, index),
        ),
        Image.asset(
          controller.icons[index],
          height: 25,
          width: 25,
          color: Colors.white,
        ),
        Text(
          controller.names[index],
          style: controller.dataTextStyle(context, index),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
