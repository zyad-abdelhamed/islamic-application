import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/next_prayer_controller.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/primary_prayer_times_container.dart';
import 'package:test_app/features/app/presentation/view/components/remaining_time_widget.dart';
import 'package:test_app/core/theme/text_styles.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({
    super.key,
    required this.nextPrayerController,
  });

  final NextPrayerController nextPrayerController;

  @override
  Widget build(BuildContext context) {
    final GetPrayersTimesController controller =
        sl<GetPrayersTimesController>();

    return Provider(
      create: (context) => nextPrayerController,
      child: ValueListenableBuilder<bool>(
        valueListenable: controller.hasErrorNotifier,
        builder: (_, hasError, __) {
          final Timings timings = controller.timings;

          return hasError
              ? ErrorWidgetIslamic(message: controller.errorMessage!)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesConstants.prayersTimePage,
                              (route) => false,
                            );
                          },
                          child: const Icon(Icons.settings_sharp),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: controller.locationEntity!.name !=
                                  AppStrings.translate("unknownCity"),
                              child: Text(
                                controller.locationEntity!.name,
                                style: TextStyles.bold20(context)
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            Text(
                              '${timings.hijriDay} '
                              '${timings.hijriMonthNameArabic} '
                              '${timings.hijriYear}',
                              style: TextStyle(
                                color: AppColors.grey400,
                                fontFamily: 'DataFontFamily',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const PrimaryPrayerTimesContainer(),
                    const RemainingTimeWidget(),
                  ],
                );
        },
      ),
    );
  }
}
