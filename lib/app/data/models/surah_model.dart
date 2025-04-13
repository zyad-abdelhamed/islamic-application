import 'package:test_app/app/domain/entities/surah_entity.dart';

class SurahModel extends SurahEntity {
  const SurahModel(
      {required super.surah,
      required super.numberOfAyat,
      required super.pageNumber});
  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      surah: json['surah'],
      numberOfAyat: json['numberOfAyat'],
      pageNumber: json['pageNumber'],
    );
  }
}
