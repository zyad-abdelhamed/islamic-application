import 'package:flutter/widgets.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';

class AdhkarModel extends AdhkarEntity {
  const AdhkarModel(
      {required super.count,
      required super.countNotifier,
      required super.description,
      required super.content});

  factory AdhkarModel.fromJson({required Map<String, dynamic> json}) {
    final int count = int.parse(json['count']);
    return AdhkarModel(
        count: count,
        countNotifier: ValueNotifier<NumberAnimationModel>(
            NumberAnimationModel(number: count)),
        description: json['description'],
        content: json['content']);
  }
}
