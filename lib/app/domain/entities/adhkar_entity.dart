import 'package:equatable/equatable.dart';

class AdhkarEntity extends Equatable {
  const AdhkarEntity(
      {required this.count, required this.description, required this.content});

  final int count;
  final String? description;
  final String content;
   
  @override
  List<Object?> get props => [count, description, content];
}
