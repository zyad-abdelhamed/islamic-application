part of 'quran_cubit.dart';

class QuranState extends Equatable {
  const QuranState(
      {this.bookMarks = const [],
      this.messageOfbookmarkFailure = '',
      this.bookMarkState = RequestStateEnum.loading,
      this.indexs = const [0],
      this.filePath,
      this.defaultPage = 0});

  final String? filePath;
  final List<int> indexs;
  final int defaultPage;
  final List<BookMarkEntity> bookMarks;
  final String messageOfbookmarkFailure;
  final RequestStateEnum bookMarkState;

  QuranState copyWith(
      {String? filePath,
      List<int>? indexs,
      int? defaultPage,
      List<BookMarkEntity>? bookMarks,
      String? messageOfbookmarkFailure,
      RequestStateEnum? bookMarkState}) {
    return QuranState(
        bookMarkState: bookMarkState ?? this.bookMarkState,
        bookMarks: bookMarks ?? this.bookMarks,
        messageOfbookmarkFailure:
            messageOfbookmarkFailure ?? this.messageOfbookmarkFailure,
        indexs: indexs ?? this.indexs,
        filePath: filePath ?? this.filePath,
        defaultPage: defaultPage ?? this.defaultPage);
  }

  @override
  List<Object?> get props => [
        filePath,
        indexs,
        defaultPage,
        bookMarkState,
        bookMarks,
        messageOfbookmarkFailure
      ];
}
