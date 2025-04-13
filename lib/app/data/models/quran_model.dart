import 'package:test_app/app/domain/entities/quran_entity.dart';

class QuranModel extends QuranEntity {
  const QuranModel(
      {required super.surah,
      required super.numberOfAyat,
      required super.pageNumber});
  factory QuranModel.fromJson(Map<String, dynamic> json) {
    return QuranModel(
      surah: json['surah'],
      numberOfAyat: json['numberOfAyat'],
      pageNumber: json['pageNumber'],
    );
  }
}
