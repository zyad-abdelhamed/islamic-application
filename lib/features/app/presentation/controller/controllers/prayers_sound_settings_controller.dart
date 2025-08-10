// prayers_sound_settings_controller.dart
import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';

class PrayersSoundsSettingsController {
  late final ValueNotifier<PrayerSoundSettingsEntity?>
      prayerSoundSettingsEntityNotifier;
  late final ValueNotifier<bool> isSwitchsShowedNotifier;
  late PrayerSoundSettingsEntity _originalPrayerSoundSettings;

  PrayersSoundsSettingsController();

  void init(PrayerSoundSettingsEntity initialSettings) {
    _originalPrayerSoundSettings = initialSettings;
    prayerSoundSettingsEntityNotifier = ValueNotifier(initialSettings);
    isSwitchsShowedNotifier = ValueNotifier(false);
  }

  void toggleIsSwitchsShowedNotifier() =>
      isSwitchsShowedNotifier.value = !isSwitchsShowedNotifier.value;

  bool get hasPrayerSoundChanges => prayerSoundSettingsEntityNotifier.value !=
          null
      ? prayerSoundSettingsEntityNotifier.value != _originalPrayerSoundSettings
      : false;

  void updatePrayerSoundSetting(String prayerKey, bool value) {
    final current = prayerSoundSettingsEntityNotifier.value;
    if (current == null) return;
    prayerSoundSettingsEntityNotifier.value =
        current.copyWithPrayer(prayerKey, value);
  }

  void cancelPrayerSoundChanges() {
    prayerSoundSettingsEntityNotifier.value = _originalPrayerSoundSettings;
  }

  PrayerSoundSettingsEntity? get currentSettings =>
      prayerSoundSettingsEntityNotifier.value;

  void markAsSaved() {
    if (prayerSoundSettingsEntityNotifier.value != null) {
      _originalPrayerSoundSettings = prayerSoundSettingsEntityNotifier.value!;
    }
  }

  void dispose() {
    prayerSoundSettingsEntityNotifier.dispose();
  }
}
