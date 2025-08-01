import 'package:test_app/features/app/data/models/location_model.dart';
import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';

abstract class BaseLocationLocalDataSource {
  Future<void> saveLocationLocaly(LocationModel locationModel);
  Future<LocationEntity?> getLocationFromLocalDataSource();
}

class LocationLocalDataSourceImpl extends BaseLocationLocalDataSource {
  static const String boxName = 'location_box';
  static const String _key = 'location';
  
  Box<LocationEntity> box = Hive.box<LocationEntity>(boxName);

  @override
  Future<LocationEntity?> getLocationFromLocalDataSource() async {
    return box.get(_key);
  }

  @override
  Future<void> saveLocationLocaly(LocationModel locationModel) async {
    await box.put(_key, locationModel);
  }
}
