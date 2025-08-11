import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/adhan_notification_service.dart'; // 📌 أضفنا خدمة الإشعارات
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';

class PrayerTimesCubit extends Cubit<NextPrayer> {
  PrayerTimesCubit(this.getPrayersTimesUseCase)
      : super(NextPrayer(name: '', time: ''));

  final GetPrayersTimesUseCase getPrayersTimesUseCase;

  /// تهيئة الكيوبت بالمواعيد
  init({required Timings timings, required BuildContext context}) {
    // 🕌 تحديد الصلاة القادمة
    final nextPrayerTime = nextPrayer(
      fajr: timings.fajr,
      dhuhr: timings.dhuhr,
      asr: timings.asr,
      maghrib: timings.maghrib,
      isha: timings.isha,
    );

    // 🔄 إرسال الصلاة القادمة للواجهة
    emit(nextPrayerTime);

    // ⏳ بدء المؤقت لغاية الصلاة القادمة
    context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");

    // 🔔 جدولة الإشعارات لكل الصلوات
    _scheduleAllPrayerNotifications(timings);

    // ⏱ إضافة مستمع لتغيير الوقت بعد كل صلاة
    intializeTimeListener(context);
  }

  static PrayerTimesCubit controller(BuildContext context) =>
      context.read<PrayerTimesCubit>();

  /// مراقبة انتهاء المؤقت وتحديد الصلاة القادمة
  intializeTimeListener(BuildContext context) {
    context.read<TimerCubit>().onTimerFinished = () {
      final timings = sl<GetPrayersTimesController>().timings;
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

  /// 📅 دالة لجدولة الإشعارات لكل الصلوات
  void _scheduleAllPrayerNotifications(Timings timings) {
    DateFormat format = DateFormat("HH:mm");
    DateTime now = DateTime.now();

    // 🕌 مواعيد الصلوات
    Map<String, String> prayers = {
      "فجر": timings.fajr,
      "ظهر": timings.dhuhr,
      "عصر": timings.asr,
      "مغرب": timings.maghrib,
      "عشاء": timings.isha,
    };

    // 🔁 المرور على كل صلاة وجدولتها
    prayers.forEach((name, timeStr) {
      // 🕒 تحويل الوقت إلى DateTime لليوم الحالي
      DateTime prayerTime = format.parse(timeStr);
      prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      // ⏭ إذا الوقت فات، نخليه لليوم التالي
      if (prayerTime.isBefore(now)) {
        prayerTime = prayerTime.add(Duration(days: 1));
      }

      // 🔔 جدولة الإشعار
      AdhanNotificationService.scheduleAdhanNotification(prayerTime);
      print("📅 تم جدولة إشعار $name في: $prayerTime");
    });
  }

  /// تحديد الصلاة القادمة
  NextPrayer nextPrayer({
    required String fajr,
    required String dhuhr,
    required String asr,
    required String maghrib,
    required String isha,
  }) {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat("HH:mm");

    Map<String, DateTime> prayers = {
      "فجر": format.parse(fajr),
      "ظهر": format.parse(dhuhr),
      "عصر": format.parse(asr),
      "مغرب": format.parse(maghrib),
      "عشاء": format.parse(isha),
    };

    // 📅 ضبط التواريخ لتكون اليوم أو اليوم التالي
    prayers.forEach((key, value) {
      prayers[key] =
          DateTime(now.year, now.month, now.day, value.hour, value.minute);
      if (prayers[key]!.isBefore(now)) {
        prayers[key] = prayers[key]!.add(Duration(days: 1));
      }
    });

    // 🕌 اختيار أقرب صلاة قادمة
    var nextPrayer =
        prayers.entries.reduce((a, b) => a.value.isBefore(b.value) ? a : b);

    return NextPrayer(
      name: nextPrayer.key,
      time: DateFormat("HH:mm").format(nextPrayer.value),
    );
  }
}
