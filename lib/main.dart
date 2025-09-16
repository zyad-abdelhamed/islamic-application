import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/init_hydrated_bloc_storage.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/local_notifications_service.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/noor_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    initDependencyInjection(),
    setupHive(),
    initHydratedBlocStorage(),
    AppStrings.load(),
  ]);

  await Future.wait([
    sl<BaseCacheService>().cacheintIalization(),
    sl<LocalNotificationsService>().init(),
    sl<BaseBackgroundTasksService>().init(),
  ]);

  runApp(const NoorApp());
}
// showcaseview أو tutorial_coach_mark
