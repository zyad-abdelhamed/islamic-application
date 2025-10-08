import '../../domain/entities/ayah_entity.dart';

class AyahModel extends AyahEntity {
  AyahModel({
    required super.number,
    required super.text,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['numberInSurah'],
      text: json['text'],
    );
  }
}
