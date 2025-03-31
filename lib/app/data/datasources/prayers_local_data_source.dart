import 'package:hive/hive.dart';
import 'package:test_app/app/domain/entities/timings.dart';

abstract class PrayersLocalDataSource {
  Future<Timings?> getLocalPrayersTimes();
  Future<void> putPrayersTimes(Timings timings);
}

class PrayersLocalDataSourceImpl extends PrayersLocalDataSource {
  static const String _boxName = 'prayers_box';
  static const String _key = 'prayers_times';

  @override
  Future<Timings?> getLocalPrayersTimes() async {
    final box = await Hive.openBox<Timings>(_boxName);
    return box.get(_key);
  }

  @override
  Future<void> putPrayersTimes(Timings timings) async {
    final box = await Hive.openBox<Timings>(_boxName);
    await box.put(_key, timings);
  }
}
