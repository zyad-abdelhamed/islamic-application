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

  intializeTimeListener(BuildContext context) {
    context.read<TimerCubit>().onTimerFinished = () {
      final timings = state.prayerTimes!;
      final nextPrayerTime = nextPrayer(
        fajr: timings.fajr,
        dhuhr: timings.dhuhr,
        asr: timings.asr,
        maghrib: timings.maghrib,
        isha: timings.isha,
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
      (r) {
        NextPrayer nextPrayerTime = nextPrayer(
            fajr: r.fajr,
            dhuhr: r.dhuhr,
            asr: r.asr,
            maghrib: r.maghrib,
            isha: r.isha);
        emit(state.copyWith(
            nextPrayer: nextPrayerTime,
            prayerTimes: r,
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
