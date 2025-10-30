import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/surah_prograss_entity.dart';

class SurahProgressAdapter extends TypeAdapter<SurahProgressEntity> {
  @override
  final int typeId = 3;

  @override
  SurahProgressEntity read(BinaryReader reader) {
    final surahName = reader.readString();
    final memorizedAyahs = (reader.read() as Set).cast<int>();

    return SurahProgressEntity(
      surahName: surahName,
      memorizedAyahs: memorizedAyahs,
    );
  }

  @override
  void write(BinaryWriter writer, SurahProgressEntity obj) {
    writer.writeString(obj.surahName);
    writer.write(obj.memorizedAyahs);
  }
}
