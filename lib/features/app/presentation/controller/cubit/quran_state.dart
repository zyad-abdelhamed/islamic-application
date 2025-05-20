part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final String? filePath;
  final int cIndex;

  const QuranState({
    this.cIndex = 0,
    this.filePath,
  });

  QuranState copyWith({
    String? filePath,
    int? cIndex,
  }) {
    return QuranState(
      cIndex: cIndex ?? this.cIndex,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  List<Object?> get props => [filePath, cIndex];
}
