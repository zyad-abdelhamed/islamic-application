import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';

class AdhkarModel extends AdhkarEntity {
  const AdhkarModel(
      {required super.count,
      required super.description,
      required super.content});
  factory AdhkarModel.fromJson( {required Map<String, dynamic> json}) =>
      AdhkarModel(
          count: int.parse(json['count']),
          description: json['description'],
          content: json['content']);
}
