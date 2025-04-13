import 'package:equatable/equatable.dart';

class QuranEntity extends Equatable {
  final String surah;
  final String numberOfAyat;
  final int pageNumber;

  const QuranEntity(
      {required this.surah,
      required this.numberOfAyat,
      required this.pageNumber});
  @override
  List<Object?> get props => [surah, numberOfAyat, pageNumber];
}
