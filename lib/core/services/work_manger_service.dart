import 'package:test_app/core/helper_function/work_manger_callback_dispatcher.dart';
import 'package:workmanager/workmanager.dart';

abstract class BaseBackgroundTasksService {
  Future<void> init();
  Future<void> registerDailyTask(String uniqueName, String taskName);
  Future<void> cancelTask(String uniqueName);
  Future<void> cancelAll();
}

class BackgroundTasksServiceImplByWorkManager
    extends BaseBackgroundTasksService {
  final Workmanager workmanager = Workmanager();

  @override
  Future<void> init() async {
    await workmanager.initialize(
      workManagerCallbackDispatcher,
      isInDebugMode: false, // خليها false في الإنتاج
    );
  }

  @override
  Future<void> registerDailyTask(String uniqueName, String taskName) async {
    // بتتسجل مرّة واحدة بس عند أول تشغيل للتطبيق (أو لما تعمل uninstall/reinstall أو تعمل cancelAll).
    await workmanager.registerPeriodicTask(
      uniqueName,
      taskName,
      frequency: const Duration(hours: 24),
      initialDelay: const Duration(hours: 24),
    );
  }

  @override
  Future<void> cancelAll() async {
    await workmanager.cancelAll();
  }

  @override
  Future<void> cancelTask(String uniqueName) {
    return workmanager.cancelByUniqueName(uniqueName);
  }
}
