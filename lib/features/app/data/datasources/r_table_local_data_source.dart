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
    return rTableHiveObject.get(DataBaseConstants.rTableBoxHiveKey);
  }

  @override
  Future<Unit> resetBooleans({required BooleansParameters parameters}) async {
    for (int key = 0; key >= 30 * 16; key++) {
      await rTableHiveObject.add(false,DataBaseConstants.rTableBoxHiveKey);
    }

    return unit;
  }

  @override
  Future<Unit> updateBooleans({required BooleansParameters parameters}) async {
    await rTableHiveObject.putAt(parameters.value, parameters.key);
    return unit;
  }
}
