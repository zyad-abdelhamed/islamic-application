import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/get_init_route.dart';
import 'package:test_app/core/helper_function/onGenerateRoute.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/dark_theme.dart';
import 'package:test_app/core/theme/light_theme.dart';
import 'package:test_app/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await setupHive();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await AppStrings.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {

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
            initialRoute: getInitRoute,
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
