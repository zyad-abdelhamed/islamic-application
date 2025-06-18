import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit(this.getPrayersTimesUseCase)
      : super(const PrayerTimesState());
  final GetPrayersTimesUseCase getPrayersTimesUseCase;

  static PrayerTimesCubit controller(BuildContext context) =>
      context.read<PrayerTimesCubit>();

  intializeTimeListener(BuildContext context) {
    context.read<TimerCubit>().onTimerFinished = () {
      final timings = state.prayerTimes;
      final nextPrayerTime = nextPrayer(
        fajr: timings[0],
        dhuhr: timings[2],
        asr: timings[3],
        maghrib: timings[4],
        isha: timings[5],
      );

      emit(state.copyWith(nextPrayer: nextPrayerTime));
      context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");
    };
  }

  void getPrayersTimes(BuildContext context) async {
    Either<Failure, Timings> result = await getPrayersTimesUseCase();
    result.fold(
      (l) {
        emit(state.copyWith(
            errorMessageofPrayerTimes: l.message,
            requestStateofPrayerTimes: RequestStateEnum.failed));
      },
      (prayerTimes) {
        NextPrayer nextPrayerTime = nextPrayer(
            fajr: prayerTimes.fajr,
            dhuhr: prayerTimes.dhuhr,
            asr: prayerTimes.asr,
            maghrib: prayerTimes.maghrib,
            isha: prayerTimes.isha);
        emit(state.copyWith(
            nextPrayer: nextPrayerTime,
            prayerTimes: [
              prayerTimes.fajr,
              prayerTimes.sunrise,
              prayerTimes.dhuhr,
              prayerTimes.asr,
              prayerTimes.maghrib,
              prayerTimes.isha
            ],
            requestStateofPrayerTimes: RequestStateEnum.success));
        context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");
        intializeTimeListener(context);
      },
    );
  }

  NextPrayer nextPrayer({
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

    return NextPrayer(
      name: nextPrayer.key,
      time: DateFormat("HH:mm").format(nextPrayer.value),
    );
  }
}
