// prayer_sound_settings_state.dart
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';

abstract class PrayerSoundSettingsState {}

class PrayerSoundSettingsInitial extends PrayerSoundSettingsState {}

class PrayerSoundSettingsLoaded extends PrayerSoundSettingsState {
  final PrayerSoundSettingsEntity settings;
  PrayerSoundSettingsLoaded(this.settings);
}

class PrayerSoundSettingsSaving extends PrayerSoundSettingsState {}

class PrayerSoundSettingsSaved extends PrayerSoundSettingsState {
  final PrayerSoundSettingsEntity settings;
  PrayerSoundSettingsSaved(this.settings);
}

class PrayerSoundSettingsError extends PrayerSoundSettingsState {
  final String message;
  PrayerSoundSettingsError(this.message);
}
