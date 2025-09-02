import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/notifications_service.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/features/notifications/domain/repos/notifications_background_tasks_base_repo.dart';
import 'package:test_app/noor_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();
  // استنى كل الـ async singletons
  await sl.allReady();

  await sl<BaseCacheService>().cacheintIalization();

  await setupHive();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  await AppStrings.load();

  await sl<BaseNotificationsService>().init();

  await sl<BaseBackgroundTasksService>().init();

  await sl<NotificationsBackgroundTasksBaseRepo>()
      .registerDailyAdhkarNotificationsTask();

  runApp(const NoorApp());
}
