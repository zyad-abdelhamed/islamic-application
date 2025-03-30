import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/helper_function/get_init_route.dart';
import 'package:test_app/core/helper_function/onGenerateRoute.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  //await Hive.initFlutter();
  await Hive.openBox(DataBaseConstants.featuerdRecordsHiveKey);
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
