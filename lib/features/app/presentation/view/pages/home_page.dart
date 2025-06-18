import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hadith_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_android_and_ios.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_desktop.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TimerCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HadithCubit>()..showTodatHadith(context),
        ),
        BlocProvider(
          create: (context) => sl<HomeCubit>()..checkLocationPermission(context)..checkInternetConnection(context),
        ),
        BlocProvider(
          create: (context) => sl<PrayerTimesCubit>()..getPrayersTimes(context),
        )
      ],
      child: adaptiveWidgetDependingOnOs(
        defaultWidget: HomePageToDesktop(),
        androidWidget: HomePageToAndroidAndIos(),
        iosWidget: HomePageToAndroidAndIos(),
      ),
    );
  }
}
