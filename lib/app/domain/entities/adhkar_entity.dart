import 'package:equatable/equatable.dart';

class AdhkarEntity extends Equatable {
  final String count;
  final String description;
  final String content;
  const AdhkarEntity(
      {required this.count, required this.description, required this.content});
  @override
  List<Object?> get props => [count, description, content];
}
