import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_state.dart';
import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';

class PrayerSoundSettingsCubit extends Cubit<PrayerSoundSettingsState> {
  final BasePrayerRepo basePrayerRepo;
  final BasePrayerTimesNotificationsRepo prayerTimesNotificationsRepo;

  PrayerSoundSettingsCubit(
      this.prayerTimesNotificationsRepo, this.basePrayerRepo)
      : super(PrayerSoundSettingsInitial());

  Future<void> loadSettings() async {
    final Either<Failure, PrayerSoundSettingsEntity> result =
        await basePrayerRepo.getPrayersSoundSettings();

    result.fold(
      (failure) => emit(PrayerSoundSettingsError(failure.message)),
      (settings) => emit(PrayerSoundSettingsLoaded(settings)),
    );
  }

  Future<void> saveSettings(PrayerSoundSettingsEntity settings) async {
    // إخطار الـ UI أن عملية الحفظ بدأت
    emit(PrayerSoundSettingsSaving());

    // حفظ الإعدادات في الـ repository
    final Either<Failure, Unit> result =
        await basePrayerRepo.savePrayersSoundSettings(settings);

    // التعامل مع نتيجة الحفظ
    await result.fold(
      (failure) {
        // لو في خطأ، نرسل state بالخطأ
        emit(PrayerSoundSettingsError(failure.message));
      },
      (_) async {
        // لو تم الحفظ بنجاح، نعيد جدولة الصلوات المتبقية
        await prayerTimesNotificationsRepo.rescheduleRemainingPrayers();

        // إرسال state بأن الإعدادات تم حفظها
        emit(PrayerSoundSettingsSaved());
      },
    );
  }
}
