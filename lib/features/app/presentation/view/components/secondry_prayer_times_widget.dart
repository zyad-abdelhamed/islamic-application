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
    return Column(
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
                  textList: AppStrings.namesOfPrayers1),
              _getColumnOfPrayers(context,
                  textList: AppStrings.emojisOfPrayers),
              Spacer(),
              _getColumnOfPrayers(context, textList: [
                timings.fajr,timings.sunrise,timings.dhuhr,timings.asr,timings.maghrib,timings.isha
              ])
            ],
          ),
        )
      ],
    );
  }

  Column _getColumnOfPrayers(BuildContext context,
      {required List<String> textList}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Text>.generate(
          6,
          (index) => Text(
            textList[index],
            textAlign: TextAlign.center,
            style: TextStyles.bold20(context).copyWith(color: Colors.brown),
          ),
        ));
  }
}
