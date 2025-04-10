import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:test_app/core/models/booleans_model.dart';

abstract class RTableLocalDataSource {
  Future<List<bool>> getBooleans();
  Future<Unit> updateBooleans({required BooleansParameters parameters});
  Future<Unit> resetBooleans({required BooleansParameters parameters});
}

class RTableLocalDataSourceImpl extends RTableLocalDataSource {
  static const String _boxName = 'rtable';
  @override
  Future<List<bool>> getBooleans() async {
    final box = await Hive.openBox<bool>(_boxName);
    return box.values.toList();
  }

  @override
  Future<Unit> resetBooleans({required BooleansParameters parameters}) async {
    final box = await Hive.openBox<bool>(_boxName);
    for (var key in box.keys) {
      box.put(key, false);
    }
    return unit;
  }

  @override
  Future<Unit> updateBooleans({required BooleansParameters parameters}) async {
    final box = await Hive.openBox<bool>(_boxName);
    await box.put(parameters.key, parameters.value);
    return unit;
  }
}
