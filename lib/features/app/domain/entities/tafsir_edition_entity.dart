import 'package:equatable/equatable.dart';

class TafsirEditionEntity extends Equatable {
  const TafsirEditionEntity({required this.name, required this.identifier});

  final String name;
  final String identifier;

  @override
  List<Object?> get props => [name, identifier];
}
