import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';

class AyahSearchResultModel extends AyahSearchResultEntity {
  const AyahSearchResultModel({
    required super.keyword,
    required super.count,
    required super.ayahs,
  });

  factory AyahSearchResultModel.fromJson(Map<String, dynamic> json) {
    return AyahSearchResultModel(
      keyword: json['keyword'] ?? '',
      count: json['count'] ?? 0,
      ayahs: (json['ayahs'] as List)
          .map((e) => SearchAyahModel.fromJson(e))
          .toList(),
    );
  }
}

class SearchAyahModel extends SearchAyahEntity {
  const SearchAyahModel({
    required super.number,
    required super.text,
    required super.numberInSurah,
    required super.juz,
    required super.page,
    required super.surah,
    required super.sajda,
  });

  factory SearchAyahModel.fromJson(Map<String, dynamic> json) {
    return SearchAyahModel(
      number: json['number'] ?? 0,
      text: json['text'] ?? '',
      numberInSurah: json['numberInSurah'] ?? 0,
      juz: json['juz'] ?? 0,
      page: json['page'] ?? 0,
      sajda: json['sajda'],
      surah: SurahModel.fromJson(json['surah']),
    );
  }
}

class SurahModel extends Surah {
  const SurahModel({
    required super.number,
    required super.name,
    required super.englishName,
    required super.englishNameTranslation,
    required super.numberOfAyahs,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      englishNameTranslation: json['englishNameTranslation'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
    );
  }
}
