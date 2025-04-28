import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_today_hadith_use_case.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getPrayersTimesUseCase,
    this.getTodayHadithUseCase,
  ) : super(HomeState());

  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  final GetTodayHadithUseCase getTodayHadithUseCase;

  void showTodatHadith(BuildContext context) async {
    Either<Failure, Hadith> result = await getTodayHadithUseCase();
    result.fold(
        (l) => null,
        (hadith) => showCupertinoDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
                alertDialogContent: (context) => Column(
                      children: <Text>[
                        Text('حديث اليوم|',
                            textAlign: TextAlign.start,
                            style: TextStyles.bold20(context).copyWith(
                                color: AppColors.secondryColor, fontSize: 23)),
                        Text(hadith.content,
                            textAlign: TextAlign.center,
                            style: TextStyles.semiBold32auto(context)
                                .copyWith(color: AppColors.white)),
                      ],
                    ))));
  }
  void showDawerInCaseLandScape(BuildContext context) {
    emit(state.copyWith(isVisible: true,
      opacity: .8,
        width: context.width * 1 / 4,
        ));
  }

  void hideDawerInCaseLandScape() {
    emit(state.copyWith(
       opacity: 0.0,
        width: 0.0));

  Future.delayed(AppDurations.longDuration,() => emit(state.copyWith(isVisible: false)));
  }

  //  ===prayer times===
  List<String> getListOfTimings(HomeState state) {
    return [
      state.prayerTimes!.fajr,
      state.prayerTimes!.sunrise,
      state.prayerTimes!.dhuhr,
      state.prayerTimes!.asr,
      state.prayerTimes!.maghrib,
      state.prayerTimes!.isha
    ];
  }

  getPrayersTimes(BuildContext context) async {
    Either<Failure, Timings> result = await getPrayersTimesUseCase();
    result.fold(
      (l) {
        emit(HomeState(
            errorMessageofPrayerTimes: l.message,
            requestStateofPrayerTimes: RequestStateEnum.failed));
      },
      (r) {
        PrayerTime nextPrayerTime = nextPrayer(
            fajr: r.fajr,
            dhuhr: r.dhuhr,
            asr: r.asr,
            maghrib: r.maghrib,
            isha: r.isha);
        emit(HomeState(
            prayerTime: nextPrayerTime,
            prayerTimes: r,
            requestStateofPrayerTimes: RequestStateEnum.success));
        context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");
      },
    );
  }

  PrayerTime nextPrayer({
    required String fajr,
    required String dhuhr,
    required String asr,
    required String maghrib,
    required String isha,
  }) {
    // الحصول على الوقت الحالي
    DateTime now = DateTime.now();
    DateFormat format = DateFormat("HH:mm");

    // تحويل أوقات الصلاة إلى DateTime
    Map<String, DateTime> prayers = {
      "فجر": format.parse(fajr),
      "ظهر": format.parse(dhuhr),
      "عصر": format.parse(asr),
      "مغرب": format.parse(maghrib),
      "عشاء": format.parse(isha),
    };

    // تعديل التواريخ لتتوافق مع اليوم الحالي
    prayers.forEach((key, value) {
      prayers[key] =
          DateTime(now.year, now.month, now.day, value.hour, value.minute);
      if (prayers[key]!.isBefore(now)) {
        prayers[key] = prayers[key]!
            .add(Duration(days: 1)); // ضبط لليوم التالي إذا مضى الوقت
      }
    });

    // تحديد الصلاة القادمة
    var nextPrayer =
        prayers.entries.reduce((a, b) => a.value.isBefore(b.value) ? a : b);

    return PrayerTime(
      name: nextPrayer.key,
      time: DateFormat("HH:mm").format(nextPrayer.value),
    );
  }
}

//ده كلاس لتخزين الصلاة والوقت
class PrayerTime {
  final String name;
  final String time;

  PrayerTime({required this.name, required this.time});
}
