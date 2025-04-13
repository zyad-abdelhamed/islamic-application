import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/app/domain/entities/timings.dart';
import 'package:test_app/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  PrayerTimesCubit(
    this.getPrayersTimesUseCase,
  ) : super(PrayerTimesState());

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
