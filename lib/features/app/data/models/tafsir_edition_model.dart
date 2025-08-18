import 'package:test_app/features/app/domain/entities/tafsir_edition_entity.dart';

class TafsirEditionModel extends TafsirEditionEntity {
  const TafsirEditionModel({required super.name, required super.identifier});
  factory TafsirEditionModel.fromJson(Map<String, dynamic> map) {
    return TafsirEditionModel(name: map["name"], identifier: map["identifier"]);
  }
}
