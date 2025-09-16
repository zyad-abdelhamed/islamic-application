import 'package:equatable/equatable.dart';

class TafsirEditState extends Equatable {
  final List<String> selected;
  final List<String> available;
  final List<String> tafsirEditions;

  const TafsirEditState({
    this.selected = const [],
    this.tafsirEditions = const [
      'تفسير البغوي',
      'تفسير السعدي',
      'تفسير ابن كثير',
      "التفسير الوسيط",
      "التفسير الميسر المجمع",
      "تفسير الطبري",
      "المختصر في التفسير",
      "الميسر في الغريب",
      "تنوير المقباس من تفسير بن عباس",
      'تفسير الجلالين',
      "تفسير القرطبي",
      "غريب القرآن لابن قتيبة",
      "تفسير ابن عاشور",
    ],
    List<String>? available,
  }) : available = available ?? tafsirEditions;

  TafsirEditState copyWith({
    List<String>? selected,
    List<String>? available,
    List<String>? tafsirEditions,
  }) {
    return TafsirEditState(
      selected: selected ?? this.selected,
      available: available ?? this.available,
      tafsirEditions: tafsirEditions ?? this.tafsirEditions,
    );
  }

  @override
  List<Object?> get props => [selected, available, tafsirEditions];
}
