import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';

abstract class PrayersLocalDataSource {
  Future<Timings?> getLocalPrayersTimes();
  Future<void> putPrayersTimes(Timings timings);
}

class PrayersLocalDataSourceImpl extends PrayersLocalDataSource {
  static const String boxName = 'prayers_box';
  static const String _key = 'prayers_times';

  Box<Timings> box = Hive.box<Timings>(boxName);

  @override
  Future<Timings?> getLocalPrayersTimes() async {
    return box.get(_key);
  }

  @override
  Future<void> putPrayersTimes(Timings timings) async {
    await box.put(_key, timings);
  }
}
