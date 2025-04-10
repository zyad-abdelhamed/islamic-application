part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final String? filePath;
  const QuranState({this.filePath});

  @override
  List<Object?> get props => [filePath];
}
