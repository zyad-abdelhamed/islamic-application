import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';

class AdhkarEntity extends Equatable {
  const AdhkarEntity(
      {required this.count,
      required this.countNotifier,
      required this.description,
      required this.content});
  final int count;
  final ValueNotifier<NumberAnimationModel> countNotifier;
  final String? description;
  final String content;

  AdhkarEntity copyWith({
    int? count,
    ValueNotifier<NumberAnimationModel>? countNotifier,
    String? description,
    String? content,
  }) {
    return AdhkarEntity(
        count: count ?? this.count,
        countNotifier: countNotifier ?? this.countNotifier,
        description: description ?? this.description,
        content: content ?? this.content);
  }

  @override
  List<Object?> get props => [count, countNotifier, description, content];
}
