import 'package:test_app/features/app/domain/entities/duaa_entity.dart';

class DuaaModel extends DuaaEntity {
  const DuaaModel({required super.title, required super.content});
  
  factory DuaaModel.fromJson(Map<String, dynamic> json) {
    return DuaaModel(title: json['title'], content: json['arabic']);
  }
}
