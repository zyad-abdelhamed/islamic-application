import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/add_daily_adhkar_page.dart';
import 'package:test_app/features/app/presentation/view/pages/edit_tafsir.dart';
import 'package:test_app/features/app/presentation/view/pages/home_page.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/features/app/presentation/view/pages/q_and_a_page.dart';
import 'package:test_app/features/app/presentation/view/pages/quran_and_tafsir_page.dart';
import 'package:test_app/features/app/presentation/view/pages/settings_page.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/location_permission_page.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/main_page.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/secondry_page.dart';
import 'package:test_app/features/splach_screen/view/pages/splash_screen.dart';
import 'package:test_app/features/app/presentation/view/pages/prayer_times_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesConstants.secondryPageOnBoarding:
      return MaterialPageRoute<SecondryPage>(
        builder: (BuildContext context) => const SecondryPage(),
      );
    case RoutesConstants.mainPageOnBoarding:
      return MaterialPageRoute<MainPage>(
        builder: (BuildContext context) => const MainPage(),
      );
    case RoutesConstants.homePageRouteName:
      return MaterialPageRoute<HomePage>(
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<TimerCubit>(
              create: (_) => sl<TimerCubit>(),
            ),
            BlocProvider<DailyAdhkarCubit>(
              create: (_) => sl<DailyAdhkarCubit>(),
            )
          ],
          child: const HomePage(),
        ),
      );
    case RoutesConstants.splashScreenRouteName:
      return MaterialPageRoute<SplashScreen>(
        builder: (BuildContext context) => const SplashScreen(),
      );
    case RoutesConstants.qAndAPageRouteName:
      return MaterialPageRoute<QAndAPage>(
        builder: (BuildContext context) => const QAndAPage(),
      );
    case RoutesConstants.prayersTimePage:
      return MaterialPageRoute<PrayerTimesPage>(
        builder: (BuildContext context) => BlocProvider(
          create: (_) => sl<PrayerSoundSettingsCubit>(),
          child: const PrayerTimesPage(),
        ),
      );
    case RoutesConstants.locationPermissionPage:
      return MaterialPageRoute<LocationPermissionPage>(
        builder: (BuildContext context) => const LocationPermissionPage(),
      );
    case RoutesConstants.addDailyAdhkarPage:
      return MaterialPageRoute<AddDailyAdhkarPage>(
          builder: (BuildContext context) => BlocProvider<DailyAdhkarCubit>(
                create: (_) => sl<DailyAdhkarCubit>(),
                child: const AddDailyAdhkarPage(),
              ));
    case RoutesConstants.settingsPage:
      return MaterialPageRoute<SettingsPage>(
        builder: (BuildContext context) => const SettingsPage(),
      );
    case RoutesConstants.quranAndTafsirPage:
      return MaterialPageRoute<QuranAndTafsirPage>(
        builder: (BuildContext context) => const QuranAndTafsirPage(),
      );
    case RoutesConstants.editTafsirPage:
      return MaterialPageRoute<QuranAndTafsirPage>(
        builder: (BuildContext context) => const EditTafsir(),
      );
    default:
      return MaterialPageRoute<Scaffold>(
        builder: (BuildContext context) => const Scaffold(),
      );
  }
}
