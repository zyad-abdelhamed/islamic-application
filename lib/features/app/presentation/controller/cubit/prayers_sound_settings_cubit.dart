import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_state.dart';

class PrayerSoundSettingsCubit extends Cubit<PrayerSoundSettingsState> {
  final BasePrayerRepo basePrayerRepo;

  PrayerSoundSettingsCubit({required this.basePrayerRepo})
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
    emit(PrayerSoundSettingsSaving());

    final Either<Failure, Unit> result =
        await basePrayerRepo.savePrayersSoundSettings(settings);

    result.fold(
      (failure) => emit(PrayerSoundSettingsError(failure.message)),
      (_) => emit(PrayerSoundSettingsSaved(settings)),
    );
  }
}
