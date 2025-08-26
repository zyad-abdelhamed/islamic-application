import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextPrayerController {
  NextPrayerController() {
    prayerRepo = sl<BasePrayerRepo>();
  }

  late final BasePrayerRepo prayerRepo;

  /// الحالة: الصلاة القادمة
  final ValueNotifier<NextPrayer> nextPrayerNotifier =
      ValueNotifier<NextPrayer>(NextPrayer(name: '', time: ''));

  /// تهيئة الكنترولر بالمواعيد
  Future<void> init({
    required Timings timings,
    required BuildContext context,
  }) async {
    final nextPrayerTime = _getNextPrayer(
      fajr: timings.fajr,
      dhuhr: timings.dhuhr,
      asr: timings.asr,
      maghrib: timings.maghrib,
      isha: timings.isha,
    );

    nextPrayerNotifier.value = nextPrayerTime;

    context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");
    _initializeTimeListener(context);

    _loadAndSchedulePrayerNotifications(timings: timings, context: context);
  }

  /// مراقبة انتهاء المؤقت وتحديد الصلاة القادمة
  void _initializeTimeListener(BuildContext context) {
    context.read<TimerCubit>().onTimerFinished = () {
      final Timings timings = sl<GetPrayersTimesController>().timings;
      final NextPrayer nextPrayerTime = _getNextPrayer(
        fajr: timings.fajr,
        dhuhr: timings.dhuhr,
        asr: timings.asr,
        maghrib: timings.maghrib,
        isha: timings.isha,
      );

      nextPrayerNotifier.value = nextPrayerTime;
      context.read<TimerCubit>().startTimerUntil("${nextPrayerTime.time}:00");
    };
  }

  /// جدولة الإشعارات
  void _scheduleAllPrayerNotifications(
    Timings timings,
    PrayerSoundSettingsEntity soundSettings,
  ) {
    DateFormat format = DateFormat("HH:mm");
    DateTime now = DateTime.now();

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

    for (var prayer in prayers) {
      if (prayer["enabled"] == false) continue;

      DateTime prayerTime = format.parse(prayer["time"] as String);
      prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      if (prayerTime.isBefore(now)) {
        prayerTime = prayerTime.add(const Duration(days: 1));
      }
    }
  }

  /// تحديد الصلاة القادمة
  NextPrayer _getNextPrayer({
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

    prayers.forEach((key, value) {
      prayers[key] =
          DateTime(now.year, now.month, now.day, value.hour, value.minute);
      if (prayers[key]!.isBefore(now)) {
        prayers[key] = prayers[key]!.add(const Duration(days: 1));
      }
    });

    var nextPrayer =
        prayers.entries.reduce((a, b) => a.value.isBefore(b.value) ? a : b);

    return NextPrayer(
      name: nextPrayer.key,
      time: DateFormat("HH:mm").format(nextPrayer.value),
    );
  }

  Future<void> _loadAndSchedulePrayerNotifications({
    required Timings timings,
    required BuildContext context,
  }) async {
    final result = await prayerRepo.getPrayersSoundSettings();

    result.fold(
      (failure) {
        AppSnackBar(
          type: AppSnackBarType.error,
          message:
              "حدث خطأ ${failure.message}، تم تفعيل جميع الصلوات افتراضيًا.",
        ).show(context);

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
        _scheduleAllPrayerNotifications(timings, settings);
      },
    );
  }

  /// تدمير الكنترولر
  void dispose() {
    nextPrayerNotifier.dispose();
  }
}
