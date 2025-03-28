import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/helper_function/get_init_route.dart';
import 'package:test_app/core/helper_function/onGenerateRoute.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/theme/cubit/theme_cubit.dart';

void main() async {
  final BaseCache baseCache = CacheImplBySharedPreferences();
  WidgetsFlutterBinding.ensureInitialized();
  await baseCache.cacheintIalization();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeCubit(),
    child: const MyApp()
     
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: Provider.of<ThemeCubit>(context).appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: getInitRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
