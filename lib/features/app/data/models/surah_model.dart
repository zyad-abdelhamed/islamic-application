import 'package:test_app/features/app/domain/entities/surah_entity.dart';

class SurahModel extends SurahEntity {
  const SurahModel({
    required super.name,
    required super.numberOfAyat,
    required super.type,
    required super.pageNumber,
    required super.isDownloaded,
  });

  factory SurahModel.fromJson({
    required Map<String, dynamic> json,
    required bool isDwonloaded,
  }) {
    return SurahModel(
      name: json["name"],
      numberOfAyat: json["ayahs"],
      type: json["type"],
      pageNumber: json["page"],
      isDownloaded: isDwonloaded,
    );
  }
}
