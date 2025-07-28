import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/splash_screen.dart';


class PrayerTimesCubit extends Cubit<NextPrayer> {
  PrayerTimesCubit(this.getPrayersTimesUseCase)
      : super(NextPrayer(name: '', time: ''));
  final GetPrayersTimesUseCase getPrayersTimesUseCase;

  init({required Timings timings, required BuildContext context}) {
    final nextPrayerTime = nextPrayer(
        fajr: timings.fajr,
        dhuhr: timings.dhuhr,
        asr: timings.asr,
        maghrib: timings.maghrib,
        isha: timings.isha);

    
     emit(nextPrayerTime);
    context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");
    intializeTimeListener(context);
  }

  static PrayerTimesCubit controller(BuildContext context) =>
      context.read<PrayerTimesCubit>();

  intializeTimeListener(BuildContext context) {
    context.read<TimerCubit>().onTimerFinished = () {
      final timings = sl<GetPrayersTimesController>().timings!;
      final nextPrayerTime = nextPrayer(
        fajr: timings.fajr,
        dhuhr: timings.dhuhr,
        asr: timings.asr,
        maghrib: timings.maghrib,
        isha: timings.isha,
      );

      emit(nextPrayerTime);
      context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");
    };
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
