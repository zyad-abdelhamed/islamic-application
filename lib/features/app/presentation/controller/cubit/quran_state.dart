part of 'quran_cubit.dart';

class QuranState extends Equatable {
  const QuranState(
      {this.bookMarks = const [],
      this.messageOfbookmarkFailure = '',
      this.bookMarkState = RequestStateEnum.loading,
      this.cIndex = 0,
      this.filePath,
      this.defaultPage = 0});

  final String? filePath;
  final int cIndex;
  final int defaultPage;
  final List<BookMarkEntity> bookMarks;
  final String messageOfbookmarkFailure;
  final RequestStateEnum bookMarkState;

  QuranState copyWith(
      {String? filePath,
      int? cIndex,
      int? defaultPage,
      List<BookMarkEntity>? bookMarks,
      String? messageOfbookmarkFailure,
      RequestStateEnum? bookMarkState}) {
    return QuranState(
        bookMarkState: bookMarkState ?? this.bookMarkState,
        bookMarks: bookMarks ?? this.bookMarks,
        messageOfbookmarkFailure:
            messageOfbookmarkFailure ?? this.messageOfbookmarkFailure,
        cIndex: cIndex ?? this.cIndex,
        filePath: filePath ?? this.filePath,
        defaultPage: defaultPage ?? this.defaultPage);
  }

  @override
  List<Object?> get props => [
        filePath,
        cIndex,
        defaultPage,
        bookMarkState,
        bookMarks,
        messageOfbookmarkFailure
      ];
}
