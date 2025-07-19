import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hadith_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_android_and_ios.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_desktop.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/features/splash_screen.dart';

bool _isInternetConnection = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    if (_isInternetConnection == false) {
      checkLocationPermission(context);
      checkInternetConnection(context);
      _isInternetConnection = true;
    }

    // تهيئة PrayerTimesCubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
     
      context.read<PrayerTimesCubit>().init(
            timings: sl<GetPrayersTimesController>().timings,
            context: context,
          );
           context.read<HadithCubit>().showTodayHadith(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return adaptiveWidgetDependingOnOs(
      defaultWidget: HomePageToDesktop(),
      androidWidget: HomePageToAndroidAndIos(),
      iosWidget: HomePageToAndroidAndIos(),
    );
  }

  void checkLocationPermission(BuildContext context) async {
    LocationPermission permission =
        await sl<BaseLocationService>().checkPermission;

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          appSneakBar(
            context: context,
            message: 'تم رفض صلاحية الموقع، سيتم عرض مواقيت الصلاة للقاهرة.',
            label: 'صلاحية الموقع',
            onPressed: () async {
              await sl<BaseLocationService>().requestPermission;
            },
            isError: true,
          );
        }
      });
    }
  }

  void checkInternetConnection(BuildContext context) async {
    final connected = await sl<InternetConnection>().checkInternetConnection();
    // إذا لم يكن متصلًا
    if (!connected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          appSneakBar(
            context: context,
            message:
                'لا يوجد اتصال بالإنترنت، يرجى الاتصال في أقرب وقت ممكن لتحديث البيانات.',
            isError: true,
          );
        }
      });
    }
  }
}
