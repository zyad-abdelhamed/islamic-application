part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final String? filePath;
  final double width;
  final double height;
  final String floatingActionButtonString;
  final int cIndex;

  const QuranState({
    this.cIndex = 0,
    this.filePath,
    this.height = 0.0,
    this.width = 0.0,
    this.floatingActionButtonString = AppStrings.theIndex,
  });

  QuranState copyWith({
    String? filePath,
    int? cIndex,
    double? width,
    double? height,
    String? floatingActionButtonString,
  }) {
    return QuranState(
      cIndex: cIndex ?? this.cIndex,
      filePath: filePath ?? this.filePath,
      width: width ?? this.width,
      height: height ?? this.height,
      floatingActionButtonString:
          floatingActionButtonString ?? this.floatingActionButtonString,
    );
  }

  @override
  List<Object?> get props =>
      [filePath, height, width, floatingActionButtonString, cIndex];
}
