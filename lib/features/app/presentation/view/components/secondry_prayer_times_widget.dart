import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';

class SecondaryPrayerTimesWidget extends StatelessWidget {
  const SecondaryPrayerTimesWidget({super.key, required this.timings});
  
  final Timings timings;
  @override
  Widget build(BuildContext context) {
    final List<String> prayerTimes = [
      timings.fajrArabic,
      timings.sunriseArabic,
      timings.dhuhrArabic,
      timings.asrArabic,
      timings.maghribArabic,
      timings.ishaArabic,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
        child: Column(
          spacing: 15.0,
          children: [
            SizedBox(
              height: 35,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(timings.gregoriandate,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyles.semiBold20(
                      context,
                    ).copyWith(color: AppColors.secondryColor)),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _getColumnOfPrayers(context,
                      textList: AppStrings.translate("namesOfPrayers1")),
                  _getColumnOfPrayers(context,
                      textList: AppStrings.translate("emojisOfPrayers")),
                  Spacer(),
                  _getColumnOfPrayers(context, textList: prayerTimes)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _getColumnOfPrayers(BuildContext context,
      {required List textList}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Text>.generate(
          6,
          (index) => Text(
            textList[index],
            textAlign: TextAlign.center,
            style: TextStyles.bold20(context).copyWith(fontFamily: 'DataFontFamily'),
          ),
        ));
  }
}
