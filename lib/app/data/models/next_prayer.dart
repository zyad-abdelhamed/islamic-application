import 'package:test_app/app/domain/entities/next_prayer_entity.dart';

class NextPrayerModel extends NextPrayerEntity {
  const NextPrayerModel(
      {required super.nameOfNextPrayer, required super.timeOfNextPrayer});
  factory NextPrayerModel.fromJson(Map<String, dynamic> json) {
    return NextPrayerModel(
        nameOfNextPrayer: json.keys.first,
        timeOfNextPrayer: json[json.keys.first]);
  }
}
