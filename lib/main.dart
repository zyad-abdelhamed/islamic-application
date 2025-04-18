import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/adapters/type_adapter_for_timings.dart';
import 'package:test_app/core/helper_function/get_init_route.dart';
import 'package:test_app/core/helper_function/onGenerateRoute.dart';
import 'package:test_app/core/helper_function/setup_hive.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await setupHive();
  Hive.registerAdapter(TypeAdapterForTimings());
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
     child: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: Provider.of<ThemeProvider>(context).appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: getInitRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
