import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/adhan_notification_service.dart';
import 'package:test_app/core/services/cache_service%20copy.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/noor_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();

  sl<BaseCacheService>().cacheintIalization();

  await AdhanNotificationService.init();

  await setupHive();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  await AppStrings.load();

  runApp(const NoorApp());
}
