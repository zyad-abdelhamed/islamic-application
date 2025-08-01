import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/features/app/domain/entities/location_type_adapter.dart';
import 'package:test_app/features/app/domain/entities/type_adapter_for_timings.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TypeAdapterForTimings());
  Hive.registerAdapter(LocationTypeAdapter());
  await Hive.openBox<int>(DataBaseConstants.featuerdRecordsHiveKey);
  await Hive.openBox<bool>(DataBaseConstants.rTableBoxHiveKey);
}
