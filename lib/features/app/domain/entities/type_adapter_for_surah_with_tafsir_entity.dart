import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

class SurahWithTafsirEntityAdapter extends TypeAdapter<SurahWithTafsirEntity> {
  @override
  final int typeId = 80;

  @override
  SurahWithTafsirEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // قراءة الآيات
    final ayahsList =
        (fields[0] as List?)?.cast<AyahEntity>() ?? <AyahEntity>[];

    // قراءة التفسير (Map<String, List<TafsirAyahEntity>>)
    final rawTafsir = fields[1];
    Map<String, List<TafsirAyahEntity>> allTafsir = {};

    if (rawTafsir != null && rawTafsir is Map) {
      allTafsir = rawTafsir.map((key, value) {
        if (value is List) {
          return MapEntry(key as String, value.cast<TafsirAyahEntity>());
        }
        return MapEntry(key as String, <TafsirAyahEntity>[]);
      });
    }

    return SurahWithTafsirEntity(
      ayahsList: ayahsList,
      allTafsir: allTafsir,
    );
  }

  @override
  void write(BinaryWriter writer, SurahWithTafsirEntity obj) {
    writer
      ..writeByte(2) // عدد الحقول
      ..writeByte(0)
      ..write(obj.ayahsList)
      ..writeByte(1)
      ..write(obj.allTafsir);
  }
}
