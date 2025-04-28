part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final String? filePath;
  final double width;
  final double height;
  final String floatingActionButtonString;
<<<<<<< HEAD
   int cIndex;

   QuranState({
    this.cIndex = 0,
    this.filePath,
    this.height = 0.0,
    this.width = 0.0,
    this.floatingActionButtonString = 'الفهرس',
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
=======
  const QuranState({this.filePath,this.height = 0.0,this.width = 0.0,this.floatingActionButtonString = AppStrings.theIndex});
>>>>>>> 4d4877b0bef4608b9bd8e741abcd1943d6454fb7

  @override
  List<Object?> get props =>
      [filePath, height, width, floatingActionButtonString, cIndex];
}
