import 'package:equatable/equatable.dart';

class SurahEntity extends Equatable {
  final String surah;
  final String numberOfAyat;
  final String type;
  final int pageNumber;

  const SurahEntity(
      {required this.surah,
      required this.numberOfAyat,
      required this.type,
      required this.pageNumber});
  @override
  List<Object?> get props => [surah, numberOfAyat, pageNumber, type];
}
