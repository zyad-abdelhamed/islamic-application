import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/init_hydrated_bloc_storage.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/local_notifications_service.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/features/app/presentation/controller/controllers/ayah_audio_card_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_audio_card.dart';
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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              final controller = AyahAudioCardController(
                audioSource: AudioSource.uri(Uri.parse(
                    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3")),
              );

              final entry = OverlayEntry(
                builder: (_) => AyahAudioCard(
                  controller: controller,
                  reciterName: "مشاري راشد العفاسي",
                  reciterImageUrl: "assets/images/book.png",
                ),
              );

              controller.setEntry(entry);
              Overlay.of(context).insert(entry);
            },
            child: Text("hello")),
      ),
    );
  }
}
// showcaseview أو tutorial_coach_mark
