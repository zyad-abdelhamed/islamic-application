import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/init_hydrated_bloc_storage.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/notifications_service.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/noor_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencyInjection();

  await sl<BaseCacheService>().cacheintIalization();

  await setupHive();

  await initHydratedBlocStorage();

  await AppStrings.load();

  await sl<BaseNotificationsService>().init();

  await sl<BaseBackgroundTasksService>().init();

  runApp(const NoorApp());
}
