import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

class SearchAyahWithTafsirEntity {
  const SearchAyahWithTafsirEntity({
    required this.ayahsAllTafsir,
    required this.ayahSearchResultEntity,
  });

  final Map<String, List<TafsirAyahEntity>> ayahsAllTafsir;
  final AyahSearchResultEntity ayahSearchResultEntity;
}

class AyahSearchResultEntity {
  final String keyword;
  final int count;
  final List<SearchAyahEntity> ayahs;

  const AyahSearchResultEntity({
    required this.keyword,
    required this.count,
    required this.ayahs,
  });
}

class SearchAyahEntity {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int page;
  final Surah surah;
  final bool sajda;

  const SearchAyahEntity({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.page,
    required this.surah,
    required this.sajda,
  });
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;

  const Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
  });
}
