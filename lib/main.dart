import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/init_hydrated_bloc_storage.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/local_notifications_service.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/noor_app.dart';

Future<void> main() async {
  // تهيئة الـ Widgets Binding والسلاش
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // تهيئة Just Audio Background قبل أي تشغيل للتطبيق
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.quran.audio',
  //   androidNotificationChannelName: 'Quran Audio',
  //   androidNotificationOngoing: true,
  // );

  // التحميلات الأولية (DI / Hive / Bloc / Strings)
  await Future.wait([
    initDependencyInjection(),
    setupHive(),
    initHydratedBlocStorage(),
    AppStrings.load(),
  ]);

  // الخدمات المحلية والمهام الخلفية
  await Future.wait([
    sl<BaseCacheService>().cacheintIalization(),
    sl<LocalNotificationsService>().init(),
    sl<BaseBackgroundTasksService>().init(),
    sl<GetPrayersTimesController>().getPrayersTimes(),
  ]);

  // إزالة شاشة السلاش وتشغيل التطبيق
  FlutterNativeSplash.remove();
  runApp(const NoorApp());
}
// showcaseview أو tutorial_coach_mark

/*تمام، خلينا نفهم المشكلة خطوة خطوة. الخطأ اللي ظهر عندك على السطر:

```dart
final ayahDurations = await Future.wait(resolvedFiles.map((file) async { ... }));
```

عادة بيحصل في **Future.wait** لما:

1. **واحد من الـ futures بيرجع null** أو حاجة غير متوافقة.
2. أو **resolvedFiles نفسها فاضية**.
3. أو **داخل الـ async map فيه exception**، زي ملف صوتي مش موجود أو فشل التحميل.

---

### الطريقة الصحيحة للتعامل مع صوت لكل آية:

لو انت شغال على Flutter وبتستخدم مثلاً `audioplayers`، ممكن تعمل حاجة زي كده:

```dart
import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer();

Future<List<Duration>> getAyahDurations(List<String> files) async {
  final List<Duration> durations = [];

  for (var file in files) {
    try {
      // تحميل الملف أو تشغيله لفترة قصيرة عشان نجيب المدة
      final duration = await player.setSourceAsset(file); // لو ملفات assets
      durations.add(duration!); // duration ممكن تكون null
    } catch (e) {
      print("Error loading $file: $e");
      durations.add(Duration.zero); // بدل ما يكسر
    }
  }

  return durations;
}
```

أو لو عايز تستخدم `Future.wait` مع safety:

```dart
final ayahDurations = await Future.wait(resolvedFiles.map((file) async {
  try {
    final duration = await player.setSourceAsset(file);
    return duration ?? Duration.zero; // لو null
  } catch (e) {
    print("Error for $file: $e");
    return Duration.zero;
  }
}));
```

---

💡 **النقاط المهمة:**

1. **لا تستخدم Future.wait بدون try/catch** على كل future.
2. **تأكد الملفات موجودة** قبل محاولة تحميلها.
3. **تعامل مع null durations** أو exceptions، عشان التطبيق ما ينهزش.

---

لو تحب أقدر أكتبلك **نسخة كاملة من الكود اللي تشغل الصوت لكل آية مع Future.wait بدون مشاكل**، بحيث كل الآيات يتم حساب مدة الصوت بشكل آمن.

تحب أعملهولك؟
*/
