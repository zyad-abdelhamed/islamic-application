import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BasePrayerRepo {
  Future<Either<Failure, Timings>> getPrayerTimes();
  Future<Either<Failure, List<Timings>>> getPrayerTimesOfMonth(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters);
  Future<Either<Failure, Unit>> savePrayersSoundSettings(PrayerSoundSettingsEntity prayerSoundSettingsEntity);
  Future<Either<Failure, PrayerSoundSettingsEntity>> getPrayersSoundSettings();
}
