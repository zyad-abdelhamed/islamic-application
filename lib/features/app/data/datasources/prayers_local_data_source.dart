import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';

abstract class PrayersLocalDataSource {
  Future<Timings?> getLocalPrayersTimes();
  Future<void> putPrayersTimes(Timings timings);

  Future<void> savePrayerSoundSettings(PrayerSoundSettingsEntity settingsModel);
  Future<PrayerSoundSettingsEntity> getPrayerSoundSettings();
}

class PrayersLocalDataSourceImpl extends PrayersLocalDataSource {
  // Box & Key لأوقات الصلاة
  static const String prayersBoxName = 'prayers_box';
  static const String prayersKey = 'prayers_times';

  final Box<Timings> prayersBox = Hive.box<Timings>(prayersBoxName);

  // Box & Key لإعدادات الصوت
  static const String soundSettingsBoxName = 'prayer_sound_settings_box';
  static const String soundSettingsKey = 'prayer_sound_settings';

  final Box<PrayerSoundSettingsEntity> soundSettingsBox =
      Hive.box<PrayerSoundSettingsEntity>(soundSettingsBoxName);

  @override
  Future<Timings?> getLocalPrayersTimes() async {
    return prayersBox.get(prayersKey);
  }

  @override
  Future<void> putPrayersTimes(Timings timings) async {
    await prayersBox.put(prayersKey, timings);
  }

  @override
  Future<PrayerSoundSettingsEntity> getPrayerSoundSettings() async {
    final settings = soundSettingsBox.get(soundSettingsKey);

    if (settings != null) {
      return settings;
    }

    // إعدادات افتراضية كلها true
    final defaultSettings = PrayerSoundSettingsEntity(
      fajr: true,
      dhuhr: true,
      asr: true,
      maghrib: true,
      isha: true,
    );

    // حفظ الإعدادات الافتراضية
    await soundSettingsBox.put(soundSettingsKey, defaultSettings);

    return defaultSettings;
  }

  @override
  Future<void> savePrayerSoundSettings(
      PrayerSoundSettingsEntity settingsModel) async {
    await soundSettingsBox.put(soundSettingsKey, settingsModel);
  }
}
