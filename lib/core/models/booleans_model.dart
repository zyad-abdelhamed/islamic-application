import 'package:equatable/equatable.dart';

class BooleansParameters extends Equatable {
  final bool value;
  final int key;
  const BooleansParameters({required this.key, required this.value});
  @override
  List<Object?> get props => [value, key];
}
