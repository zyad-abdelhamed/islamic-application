import 'package:hive/hive.dart';
import 'prayer_sound_settings_entity.dart';

class PrayerSoundSettingsAdapter extends TypeAdapter<PrayerSoundSettingsEntity> {
  @override
  final int typeId = 5;

  @override
  PrayerSoundSettingsEntity read(BinaryReader reader) {
    return PrayerSoundSettingsEntity(
      fajr: reader.readBool(),
      dhuhr: reader.readBool(),
      asr: reader.readBool(),
      maghrib: reader.readBool(),
      isha: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, PrayerSoundSettingsEntity obj) {
    writer.writeBool(obj.fajr);
    writer.writeBool(obj.dhuhr);
    writer.writeBool(obj.asr);
    writer.writeBool(obj.maghrib);
    writer.writeBool(obj.isha);
  }
}
