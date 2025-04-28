import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_today_hadith_use_case.dart';
import 'package:test_app/features/app/presentation/view/components/show_custom_alert_dialog.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<PrayerTimesState> {
  HomeCubit(
    this.getPrayersTimesUseCase,
    this.getTodayHadithUseCase,
  ) : super(PrayerTimesState());

  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  final GetTodayHadithUseCase getTodayHadithUseCase;

  void showTodatHadith(BuildContext context) async {
    Either<Failure, Hadith> result = await getTodayHadithUseCase();
    result.fold((l) => print(l.message), (hadith) {
      print('solllu');
      showCupertinoDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
                  alertDialogContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Text>[
                  Text('حديث اليوم|',
                      style: TextStyles.semiBold32auto(context)
                          .copyWith(color: AppColors.secondryColor)),
                  Text(hadith.content,
                      textAlign: TextAlign.start,
                      style: TextStyles.bold20(context)
                          .copyWith(color: AppColors.white, fontSize: 23)),
                ],
              )));
    });
  }

  //  ===prayer times===
  List<String> getListOfTimings(PrayerTimesState state) {
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
        print('error');
        emit(PrayerTimesState(
            errorMessageofPrayerTimes: l.message,
            requestStateofPrayerTimes: RequestStateEnum.failed));
      },
      (r) {
        print('success');
        PrayerTime nextPrayerTime = nextPrayer(
            fajr: r.fajr,
            dhuhr: r.dhuhr,
            asr: r.asr,
            maghrib: r.maghrib,
            isha: r.isha);
        emit(PrayerTimesState(
            prayerTime: nextPrayerTime,
            prayerTimes: r,
            requestStateofPrayerTimes: RequestStateEnum.success));
        print("الصلاة القادمة: ${nextPrayerTime.name}");
        print("وقت الصلاة القادمة: ${nextPrayerTime.time}");

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
