import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/models/booleans_model.dart';

abstract class RTableLocalDataSource {
  Future<List<bool>> getBooleans();
  Future<Unit> updateBooleans({required BooleansParameters parameters});
  Future<Unit> resetBooleans();
}

class RTableLocalDataSourceImpl extends RTableLocalDataSource {
 final  Box<bool> _box = Hive.box<bool>(DataBaseConstants.rTableBoxHiveKey);

  @override
  Future<List<bool>> getBooleans() async {
    final data = _box.values.toList();

    if (data.isEmpty || data.length != 30 * 16) {
      await _box.clear();

      final Map<int, bool> entries = {
        for (int i = 0; i < 30 * 16; i++) i: false
      };
      await _box.putAll(entries);

      return List.filled(30 * 16, false);
    }

    return data;
  }

  @override
  Future<Unit> resetBooleans() async {
    await _box.clear();

    final Map<int, bool> entries = {
      for (int i = 0; i < 30 * 16; i++) i: false
    };
    await _box.putAll(entries);

    return unit;
  }

  @override
  Future<Unit> updateBooleans({required BooleansParameters parameters}) async {
    await _box.put(parameters.key, parameters.value);
    return unit;
  }
}
