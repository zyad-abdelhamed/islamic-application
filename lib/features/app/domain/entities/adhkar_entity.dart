import 'package:equatable/equatable.dart';

class AdhkarEntity extends Equatable {
  const AdhkarEntity(
      {required this.count, required this.description, required this.content});
  final int count;
  final String? description;
  final String content;

  AdhkarEntity copyWith({
    int? count,
    String? description,
    String? content,
  }) {
    return AdhkarEntity(
        count: count ?? this.count,
        description: description ?? this.description,
        content: content ?? this.content);
  }

  @override
  List<Object?> get props => [count, description, content];
}
