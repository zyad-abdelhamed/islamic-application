import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';

class AdhkarModel extends AdhkarEntity {
  const AdhkarModel(
      {required super.count,
      required super.description,
      required super.content});

  factory AdhkarModel.fromJson({required Map<String, dynamic> json}) {
    final int count = int.parse(json['count']);

    return AdhkarModel(
        count: count,
        description: json['description'],
        content: json['content']);
  }
}
