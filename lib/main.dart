import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_init_route.dart';
import 'package:test_app/core/helper_function/onGenerateRoute.dart';
import 'package:test_app/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: getInitRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }
}


