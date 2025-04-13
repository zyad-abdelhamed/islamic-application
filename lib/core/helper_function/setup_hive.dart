import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  await Hive.openBox<int>(DataBaseConstants.featuerdRecordsHiveKey);
  await Hive.openBox<bool>(DataBaseConstants.cacheVariblesHiveKey);
}
