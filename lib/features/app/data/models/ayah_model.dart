import '../../domain/entities/ayah_entity.dart';

class AyahModel extends AyahEntity {
  AyahModel({
    required super.number,
    required super.text,
    required super.sajda,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['numberInSurah'],
      text: json['text'],
      sajda: json['sajda'],
    );
  }
}
