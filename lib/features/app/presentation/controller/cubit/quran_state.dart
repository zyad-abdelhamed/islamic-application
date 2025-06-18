part of 'quran_cubit.dart';

class QuranState extends Equatable {

  const QuranState({
    this.cIndex = 0,
    this.filePath,
    this.defaultPage = 0
  });
  
  final String? filePath;
  final int cIndex;
  final int defaultPage; 

  QuranState copyWith({
    String? filePath,
    int? cIndex,
    int? defaultPage
  }) {
    return QuranState(
      cIndex: cIndex ?? this.cIndex,
      filePath: filePath ?? this.filePath,
      defaultPage: defaultPage ?? this.defaultPage
    );
  }

  @override
  List<Object?> get props => [filePath, cIndex, defaultPage];
}
