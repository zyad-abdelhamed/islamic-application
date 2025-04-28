import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/models/booleans_model.dart';
import 'package:test_app/core/services/data_base_service.dart';

abstract class RTableLocalDataSource {
  Future<List<bool>> getBooleans();
  Future<Unit> updateBooleans({required BooleansParameters parameters});
  Future<Unit> resetBooleans({required BooleansParameters parameters});
}

class RTableLocalDataSourceImpl extends RTableLocalDataSource {
  final BaseDataBaseService<bool> rTableHiveObject = HiveDatabaseService<bool>(
      box: Hive.box(DataBaseConstants.rTableBoxHiveKey));

  @override
  Future<List<bool>> getBooleans() async {
    final data = await rTableHiveObject.get(DataBaseConstants.rTableBoxHiveKey);

    if (data.isEmpty || data.length != 30 * 16) {
      await rTableHiveObject.deleteAll(DataBaseConstants.rTableBoxHiveKey);
      
      
      final Map<int, bool> entries = {
        for (int i = 0; i < 30 * 16; i++) i: false
      };
      await rTableHiveObject.putAll(entries);

      return List.filled(30 * 16, false);
    }

    return data;
  }

  @override
  Future<Unit> resetBooleans({required BooleansParameters parameters}) async {
    await rTableHiveObject.deleteAll(DataBaseConstants.rTableBoxHiveKey);
    final Map<int, bool> entries = {
      for (int i = 0; i < 30 * 16; i++) i: false
    };
    await rTableHiveObject.putAll(entries);
    return unit;
  }

  @override
  Future<Unit> updateBooleans({required BooleansParameters parameters}) async {
    await rTableHiveObject.put(parameters.key, parameters.value);
    return unit;
  }
}
