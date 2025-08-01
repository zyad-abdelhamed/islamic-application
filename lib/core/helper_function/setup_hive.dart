import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/features/app/data/datasources/location_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';
import 'package:test_app/features/app/domain/entities/location_type_adapter.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/entities/type_adapter_for_timings.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TypeAdapterForTimings());
  Hive.registerAdapter(LocationTypeAdapter());
  await Hive.openBox<int>(DataBaseConstants.featuerdRecordsHiveKey);
  await Hive.openBox<bool>(DataBaseConstants.rTableBoxHiveKey);
  await Hive.openBox<LocationEntity>(LocationLocalDataSourceImpl.boxName);
  await Hive.openBox<Timings>(PrayersLocalDataSourceImpl.boxName);
}
