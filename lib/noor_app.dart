import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/core/helper_function/get_init_route.dart';
import 'package:test_app/core/helper_function/onGenerateRoute.dart';
import 'package:test_app/core/theme/dark_theme.dart';
import 'package:test_app/core/theme/light_theme.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/view/components/change_interval_between_adhkar_notifications.dart';

class NoorApp extends StatelessWidget {
  const NoorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (_, isDarkMode) {
          return MaterialApp(
            locale: const Locale('ar'),
            supportedLocales: const [
              Locale('ar'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: isDarkMode ? darkTheme : lightTheme,
            debugShowCheckedModeBanner: false,
            //initialRoute: getInitRoute,
            home: const AdhkarSettingsScreen(),
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
