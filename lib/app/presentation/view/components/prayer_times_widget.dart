import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';
import 'package:test_app/timer/cubit/timer_state.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      decoration: _boxDecoration(color: AppColors.primaryColor),
      child: Container(
        height: context.height * .22,
        width: double.infinity,
        decoration: _boxDecoration(
            color: AppColors.inActivePrimaryColor.withValues(alpha: .3)),
        margin: EdgeInsets.only(top: context.width * .08),
        padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(),
            Row(spacing: 5.0, children: [
              textNextPrayer(context: context, text: 'الصلاة القادمة :'),
              BlocConsumer<TimerCubit, TimerState>(
                listenWhen: (previous, current) =>
                    previous.nextPrayer != current.nextPrayer,
                buildWhen: (previous, current) =>
                    previous.nextPrayer != current.nextPrayer,
                listener: (context, state) {
                  if (state.seconds == 0 &&
                      state.minutes == 0 &&
                      state.hours == 0) {
                    context.read<TimerCubit>().getRemainingTime();
                  }
                },
                builder: (context, state) {
                  print("next prayer rebuild${state.nextPrayerRequestState}");
                  if (state.nextPrayerRequestState ==
                      RequestStateEnum.success) {
                    return textNextPrayer(
                        context: context,
                        text: _getNextPrayerNameInArabic(state));
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ])
          ],
        ),
      ),
    );
  }

  String _getNextPrayerNameInArabic(TimerState state) {
    switch (state.nextPrayer!.nameOfNextPrayer) {
      case "Fajr":
        return "الفجر";
      case "Dhuhr":
        return "الظهر";
      case "Asr":
        return "العصر";
      case "Maghrib":
        return "المغرب";
      case "Isha":
        return "العشاء";
      default:
        return '';
    }
  }

  Text textNextPrayer({required BuildContext context, required String text}) {
    return Text(
      text,
      style: TextStyles.bold20(context).copyWith(
          color: AppColors.secondryColor,
          shadows: [
            BoxShadow(
                // blurRadius: 2,
                spreadRadius: 2,
                offset: const Offset(-5.0, -5.0),
                color: AppColors.purple.withValues(alpha: 0.2))
          ],
          fontSize: 28),
    );
  }
}

List<String> prayerTimes = ['5:2', '5:2', '5:2', '5:2', '5:2','5,2'];
BoxDecoration _boxDecoration({required Color color}) =>
    BoxDecoration(borderRadius: BorderRadius.circular(35.0), color: color);
