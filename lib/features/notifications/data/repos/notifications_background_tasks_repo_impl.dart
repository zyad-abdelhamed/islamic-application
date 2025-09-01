import 'package:test_app/core/constants/tasks_constants.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/features/notifications/data/data_sources/local_data_source/notifications_background_tasks_local_data_source.dart';
import 'package:test_app/features/notifications/domain/repos/base_daily_adhkar_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/notifications_background_tasks_base_repo.dart';

class NotificationsBackgroundTasksRepoImpl
    implements NotificationsBackgroundTasksBaseRepo {
  NotificationsBackgroundTasksRepoImpl(
    this.localDataSource,
    this.dailyAdhkarNotificationsRepo,
    this.prayerTimesNotificationsRepo,
    this._backgroundTasksService,
  );
  final BaseNotificationsBackgroundTasksLocalDataSource localDataSource;
  final BaseDailyAdhkarNotificationsRepo dailyAdhkarNotificationsRepo;
  final BasePrayerTimesNotificationsRepo prayerTimesNotificationsRepo;
  final BaseBackgroundTasksService _backgroundTasksService;

  @override
  Future<void> registerDailyAdhkarNotificationsTask() async {
    final bool isNotRegistered = localDataSource.isDailyAdhkarNotRegistered();

    if (isNotRegistered) {
      await dailyAdhkarNotificationsRepo.scheduleDailyAdhkar();
      await _backgroundTasksService.registerDailyTask(
        TasksConstants.dailyAdhkarUniqueName,
        TasksConstants.dailyAdhkarTaskName,
      );

      await localDataSource.setDailyIsAdhkarNotRegistered(false);
    }
  }

  @override
  Future<void> registerPrayerTimesNotificationsTask() async {
    final bool isNotRegistered = localDataSource.isPrayerTimesNotRegistered();

    if (isNotRegistered) {
      await prayerTimesNotificationsRepo.schedulePrayersNotifications();
      await _backgroundTasksService.registerDailyTask(
        TasksConstants.prayerTimesUniqueName,
        TasksConstants.prayerTimestaskName,
      );

      await localDataSource.setPrayerTimesIsNotRegistered(false);
    }
  }

  @override
  Future<void> cancelDailyAdhkarNotificationsTask() async {
    await _backgroundTasksService
        .cancelTask(TasksConstants.dailyAdhkarUniqueName);
    await localDataSource.setDailyIsAdhkarNotRegistered(true);
  }

  @override
  Future<void> cancelPrayerTimesNotificationsTask() async {
    await _backgroundTasksService
        .cancelTask(TasksConstants.prayerTimesUniqueName);
    await localDataSource.setPrayerTimesIsNotRegistered(true);
  }
}
