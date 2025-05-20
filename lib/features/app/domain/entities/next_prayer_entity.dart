import 'package:equatable/equatable.dart';

class NextPrayer extends Equatable{
  final String name;
  final String time;

  const NextPrayer({required this.name, required this.time});
  
  @override
  List<Object?> get props => [name, time];
}