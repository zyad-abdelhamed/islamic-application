import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/adhan_notification_service.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';

class PrayerTimesCubit extends Cubit<NextPrayer> {
  PrayerTimesCubit(this.prayerRepo)
      : super(NextPrayer(name: '', time: ''));

  final BasePrayerRepo prayerRepo;

  /// تهيئة الكيوبت بالمواعيد
  init({required Timings timings, required BuildContext context}) async {
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
    intializeTimeListener(context);

///////////////////////////
    _loadAndSchedulePrayerNotifications(timings: timings, context: context);
    // 🔔 جدولة الإشعارات لكل الصلوات
  }

  static PrayerTimesCubit controller(BuildContext context) =>
      context.read<PrayerTimesCubit>();

  /// مراقبة انتهاء المؤقت وتحديد الصلاة القادمة
  intializeTimeListener(BuildContext context) {
    context.read<TimerCubit>().onTimerFinished = () {
      final Timings timings = sl<GetPrayersTimesController>().timings;
      final NextPrayer nextPrayerTime = nextPrayer(
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

  /// 📅 دالة لجدولة الإشعارات لكل الصلوات حسب الإعدادات
  void _scheduleAllPrayerNotifications(
      Timings timings, PrayerSoundSettingsEntity soundSettings) {
    DateFormat format = DateFormat("HH:mm");
    DateTime now = DateTime.now();

    // 🕌 مواعيد الصلوات مع إعدادات الصوت
    final prayers = [
      {"name": "فجر", "time": timings.fajr, "enabled": soundSettings.fajr},
      {"name": "ظهر", "time": timings.dhuhr, "enabled": soundSettings.dhuhr},
      {"name": "عصر", "time": timings.asr, "enabled": soundSettings.asr},
      {
        "name": "مغرب",
        "time": timings.maghrib,
        "enabled": soundSettings.maghrib
      },
      {"name": "عشاء", "time": timings.isha, "enabled": soundSettings.isha},
    ];

    // 🔁 المرور على كل صلاة وجدولتها إذا مفعلة
    for (var prayer in prayers) {
      if (prayer["enabled"] == false) {
        print("🚫 تم تخطي إشعار ${prayer["name"]} لأنه غير مفعل في الإعدادات");
        continue; // تخطي الصلاة إذا الإعداد False
      }

      // 🕒 تحويل الوقت إلى DateTime لليوم الحالي
      DateTime prayerTime = format.parse(prayer["time"] as String);
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
      print("📅 تم جدولة إشعار ${prayer["name"]} في: $prayerTime");
    }
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

  Future<void> _loadAndSchedulePrayerNotifications(
      {required Timings timings, required BuildContext context}) async {
    final result = await prayerRepo.getPrayersSoundSettings();

    result.fold(
      (failure) {
        // 🛑 في حالة الخطأ - نظهر SnackBar أوضح
        appSneakBar(
          isError: true,
          context: context,
          message:
              "حدث خطأ ${failure.message}، تم تفعيل جميع الصلوات افتراضيًا.",
        );

        print(
            "⚠️ Error loading settings: ${failure.toString()} - Using default (all true)");

        // ✅ تفعيل كل القيم كـ true
        final defaultSettings = PrayerSoundSettingsEntity(
          fajr: true,
          dhuhr: true,
          asr: true,
          maghrib: true,
          isha: true,
        );

        _scheduleAllPrayerNotifications(timings, defaultSettings);
      },
      (settings) {
        print("✅ Prayer settings loaded: $settings");
        _scheduleAllPrayerNotifications(timings, settings);
      },
    );
  }
}
