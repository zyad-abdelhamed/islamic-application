import '../../domain/entities/tafsir_ayah_entity.dart';

class TafsirAyahModel extends TafsirAyahEntity {
  TafsirAyahModel({
    required super.number,
    required super.text,
  });

  factory TafsirAyahModel.fromJson(Map<String, dynamic> json) {
    return TafsirAyahModel(
      number: json['numberInSurah'],
      text: json['text'],
    );
  }
}

