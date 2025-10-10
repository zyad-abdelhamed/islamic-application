import 'package:test_app/features/app/domain/entities/reciters_entity.dart';

class RecitersModel extends ReciterEntity {
  const RecitersModel(
      {required super.identifier,
      required super.language,
      required super.name,
      required super.image});

  factory RecitersModel.fromJson(Map<String, dynamic> json) {
    return RecitersModel(
      identifier: json['identifier'] ?? '',
      language: json['language'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
