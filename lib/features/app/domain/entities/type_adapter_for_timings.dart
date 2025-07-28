import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';

class TypeAdapterForTimings extends TypeAdapter<Timings> {
  @override
  Timings read(BinaryReader reader) {
    return Timings(fajr: reader.readString(),
      sunrise: reader.readString(),
      dhuhr: reader.readString(),
      asr: reader.readString(),
      maghrib: reader.readString(),
      isha: reader.readString(),
      hijriDay: reader.readString(),
      hijriMonthNameArabic: reader.readString(),
      hijriYear: reader.readString(),
      gregoriandate: reader.readString());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Timings obj) {
    writer.writeString(obj.fajr);
    writer.writeString(obj.sunrise);
    writer.writeString(obj.dhuhr);
    writer.writeString(obj.asr);
    writer.writeString(obj.maghrib);
    writer.writeString(obj.isha);
    writer.writeString(obj.hijriDay);
    writer.writeString(obj.hijriMonthNameArabic);
    writer.writeString(obj.hijriYear);
    writer.writeString(obj.gregoriandate);
  }
}
