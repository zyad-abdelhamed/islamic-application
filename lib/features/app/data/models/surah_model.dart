import 'package:test_app/features/app/domain/entities/surah_entity.dart';

class SurahModel extends SurahEntity {
  const SurahModel(
      {required super.name,
      required super.numberOfAyat,
      required super.type,
      required super.pageNumber});
  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      name: json["name"],
      numberOfAyat: json["ayahs"],
      type: json["type"],
      pageNumber: json["page"],
    );
  }
}
