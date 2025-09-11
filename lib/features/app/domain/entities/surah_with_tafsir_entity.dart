import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

class SurahWithTafsirEntity {
  final List<AyahEntity> ayahsList;
  final Map<String, List<TafsirAyahEntity>> allTafsir;

  const SurahWithTafsirEntity(
      {required this.ayahsList, required this.allTafsir});
}
