import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/splash_screen.dart';

class PrimaryPrayerTimesContainer extends StatelessWidget {
  const PrimaryPrayerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0), //spacing
      decoration: _boxDecoration(color: AppColors.primaryColor),
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: _getRowOfPrayers(
                context,
                textList: [
                  sl<GetPrayersTimesController>().timings!.fajr,
                  sl<GetPrayersTimesController>().timings!.sunrise,
                  sl<GetPrayersTimesController>().timings!.dhuhr,
                  sl<GetPrayersTimesController>().timings!.asr,
                  sl<GetPrayersTimesController>().timings!.maghrib,
                  sl<GetPrayersTimesController>().timings!.isha
                ],
              )),
          Container(
            height: 200,
            width: double.infinity,
            decoration: _boxDecoration(
                color: AppColors.inActivePrimaryColor.withValues(alpha: .3)),
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getRowOfPrayers(context, textList: AppStrings.namesOfPrayers1),
                _getRowOfPrayers(context, textList: AppStrings.emojisOfPrayers),
                Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(AppStrings.nextPrayer,
                      style: TextStyles.semiBold16(
                          context: context, color: AppColors.grey400)),
                  BlocBuilder<PrayerTimesCubit, NextPrayer>(
                    builder: (context, state) {
                      return Text("ال${state.name}",
                          style: TextStyles.bold20(context).copyWith(
                              color: AppColors.secondryColor,
                              shadows: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    offset: const Offset(-5.0, -5.0),
                                    color:
                                        AppColors.purple.withValues(alpha: 0.2))
                              ],
                              fontSize: 35,
                              fontFamily: 'DataFontFamily'));
                    },
                  ),
                ])
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
        children: List<Text>.generate(
          6,
          (index) => Text(
            textList[index],
            textAlign: TextAlign.center,
            style: TextStyles.bold20(context).copyWith(color: AppColors.white),
          ),
        ));
  }

  BoxDecoration _boxDecoration({required Color color}) =>
      BoxDecoration(borderRadius: BorderRadius.circular(35.0), color: color);
}
