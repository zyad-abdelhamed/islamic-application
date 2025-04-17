import 'package:equatable/equatable.dart';

class Hadith extends Equatable{
  final String content;

  const Hadith({required this.content});
  @override
  List<Object?> get props => [content];
}