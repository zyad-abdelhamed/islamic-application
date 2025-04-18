import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/core/adapters/type_adapter_for_timings.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TypeAdapterForTimings());
  await Hive.openBox<int>(DataBaseConstants.featuerdRecordsHiveKey);
  await Hive.openBox<bool>(DataBaseConstants.cacheVariblesHiveKey);
  await Hive.openBox<bool>(DataBaseConstants.rTableBoxHiveKey);
  //await Hive.box<bool>(DataBaseConstants.rTableBoxHiveKey).clear();
    for (int key = 0; key >= (30 * 16); key++) {
      Hive.box<bool>(DataBaseConstants.rTableBoxHiveKey).add(false);
  }
}
