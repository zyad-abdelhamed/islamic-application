import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

class TafsirAyahModel extends TafsirAyahEntity {
  const TafsirAyahModel({required super.text});

  factory TafsirAyahModel.fromJson(Map<String, dynamic> json) {
    return TafsirAyahModel(
        text: json["text"] ?? "لا يوجد تفسير متاح لهذه الآية");
  }
}
