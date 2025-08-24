import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/primary_prayer_times_container_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/next_prayer_widget.dart';

class PrayerTimesInnerContainer extends StatelessWidget {
  const PrayerTimesInnerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final PrimaryPrayerTimesContainerController controller =
        PrimaryPrayerTimesContainerController.instance;

    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
      padding: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
      decoration: controller.boxDecoration(
        color: ThemeCubit.controller(context).state
            ? AppColors.darkModeInActiveColor
            : AppColors.lightModeInActiveColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // أيقونة + اسم الصلاة
          ValueListenableBuilder(
              valueListenable:
                  context.read<NextPrayerController>().nextPrayerNotifier,
              builder: (context, value, child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        controller.names.length,
                        (index) => Expanded(
                              child: AnimatedContainer(
                                duration: AppDurations.longDuration,
                                decoration: controller.highlightBoxDecoration(
                                    context, index),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      controller.icons[index],
                                      height: 25,
                                      width: 25,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.names[index],
                                      style: controller.dataTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
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
