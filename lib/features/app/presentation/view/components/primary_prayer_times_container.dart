import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/view/components/next_prayer_widget.dart';

class PrimaryPrayerTimesContainer extends StatelessWidget {
  const PrimaryPrayerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = sl<GetPrayersTimesController>();
    final timings = controller.timings;

    final List<String> prayerTimes = [
      timings.fajr,
      timings.sunrise,
      timings.dhuhr,
      timings.asr,
      timings.maghrib,
      timings.isha,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: _boxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: _getRowOfPrayers(context, textList: prayerTimes),
          ),
          Container(
            height: 200,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            decoration: _boxDecoration(
              color: AppColors.inActivePrimaryColor.withValues(alpha: .3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getRowOfPrayers(context, textList: AppStrings.namesOfPrayers1),
                _getRowOfPrayers(context, textList: AppStrings.emojisOfPrayers),
                const Spacer(),
                NextPrayerWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _getRowOfPrayers(BuildContext context, {required List<String> textList}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        textList.length,
        (index) => Text(
          textList[index],
          textAlign: TextAlign.center,
          style: TextStyles.bold20(context).copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration({required Color color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(35.0),
      color: color,
    );
  }
}
