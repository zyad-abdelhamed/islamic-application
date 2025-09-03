import 'package:equatable/equatable.dart';

class SurahEntity extends Equatable {
  final String name;
  final int numberOfAyat;
  final String type;
  final int pageNumber;

  const SurahEntity(
      {required this.name,
      required this.numberOfAyat,
      required this.type,
      required this.pageNumber});
  @override
  List<Object?> get props => [name, numberOfAyat, pageNumber, type];
}
