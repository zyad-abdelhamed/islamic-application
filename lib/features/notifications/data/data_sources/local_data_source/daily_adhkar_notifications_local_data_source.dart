import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/services/cache_service.dart';

abstract class BaseDailyAdhkarNotificationsLocalDataSource {
  int getMinutes();
  Future<void> setMinutes(int minutes);
}

class DailyAdhkarNotificationsLocalDataSourceImpl
    extends BaseDailyAdhkarNotificationsLocalDataSource {
  DailyAdhkarNotificationsLocalDataSourceImpl({required this.cache});

  final BaseCacheService cache;

  @override
  int getMinutes() =>
      cache.getIntFromCache(key: CacheConstants.repeatIntervalKey) ?? 60;

  @override
  Future<void> setMinutes(int minutes) async {
    await cache.insertIntToCache(
        key: CacheConstants.repeatIntervalKey, value: minutes);
  }
}
