import 'package:test_app/features/app/data/models/location_model.dart';
import 'package:hive/hive.dart';

abstract class BaseLocationLocalDataSource {
  Future<void> saveLocationLocaly(LocationModel locationModel);
  Future<LocationModel?> getLocationFromLocalDataSource();
}

class LocationLocalDataSourceImpl extends BaseLocationLocalDataSource {
  static const String _boxName = 'location_box';
  static const String _key = 'location';

  @override
  Future<LocationModel?> getLocationFromLocalDataSource() async {
    final box = await Hive.openBox<LocationModel>(_boxName);
    return box.get(_key);
  }

  @override
  Future<void> saveLocationLocaly(LocationModel locationModel) async {
    final box = await Hive.openBox<LocationModel>(_boxName);
    await box.put(_key, locationModel);
  }
}
