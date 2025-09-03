import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/services/cache_service.dart';

abstract class BaseNotificationsBackgroundTasksLocalDataSource {
  bool isDailyAdhkarNotRegistered();
  Future<void> setDailyIsAdhkarNotRegistered(bool value);
  bool isPrayerTimesNotRegistered();
  Future<void> setPrayerTimesIsNotRegistered(bool value);
}

class NotificationsBackgroundTasksLocalDataSource
    implements BaseNotificationsBackgroundTasksLocalDataSource {
  NotificationsBackgroundTasksLocalDataSource({required this.cache});

  final BaseCacheService cache;

  @override
  bool isDailyAdhkarNotRegistered() {
    return cache.getboolFromCache(
            key: CacheConstants.isDailyAdhkarNotRegisteredInWorkManger) ??
        true;
  }

  @override
  Future<void> setDailyIsAdhkarNotRegistered(bool value) async {
    await cache.insertBoolToCache(
        key: CacheConstants.isDailyAdhkarNotRegisteredInWorkManger,
        value: value);
  }

  @override
  bool isPrayerTimesNotRegistered() {
    return cache.getboolFromCache(
            key: CacheConstants.isPrayerTimesNotRegisteredInWorkManger) ??
        true;
  }

  @override
  Future<void> setPrayerTimesIsNotRegistered(bool value) async {
    await cache.insertBoolToCache(
        key: CacheConstants.isPrayerTimesNotRegisteredInWorkManger,
        value: value);
  }
}
