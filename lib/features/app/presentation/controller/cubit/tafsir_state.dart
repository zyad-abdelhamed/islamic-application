import 'package:equatable/equatable.dart';

class TafsirEditState extends Equatable {
  final List<String> selected;
  final List<String> available;

  const TafsirEditState({
    required this.selected,
    required this.available,
  });

  TafsirEditState copyWith({
    List<String>? selected,
    List<String>? available,
  }) {
    return TafsirEditState(
      selected: selected ?? this.selected,
      available: available ?? this.available,
    );
  }

  @override
  List<Object?> get props => [selected, available];
}
