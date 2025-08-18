import 'package:equatable/equatable.dart';

class DuaaEntity extends Equatable{
  final String title;
  final String content;

  const DuaaEntity({
    required this.title,
    required this.content,
  });
  
  @override
  List<Object?> get props => [title, content];
}
