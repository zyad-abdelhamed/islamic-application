import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';

class NextPrayerModel extends NextPrayer {
  const NextPrayerModel({required super.name, required super.time});
  factory NextPrayerModel.fromJson(Map<String, dynamic> json) {
    return NextPrayerModel(name: json.keys.first, time: json[json.keys.first]);
  }
}
