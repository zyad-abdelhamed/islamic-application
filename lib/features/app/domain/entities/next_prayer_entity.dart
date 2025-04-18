import 'package:equatable/equatable.dart';

class NextPrayerEntity extends Equatable {
  final String nameOfNextPrayer, timeOfNextPrayer;

  const NextPrayerEntity(
      {required this.nameOfNextPrayer, required this.timeOfNextPrayer});
  @override
  List<Object?> get props => [nameOfNextPrayer, timeOfNextPrayer];
}
