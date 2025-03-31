import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/adapters/type_adapter_for_timings.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/helper_function/get_init_route.dart';
import 'package:test_app/core/helper_function/onGenerateRoute.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await Hive.initFlutter();
  Hive.registerAdapter(TypeAdapterForTimings());
  await Hive.openBox(DataBaseConstants.featuerdRecordsHiveKey);
  //await addsoliman(DataBaseConstants.featuerdRecordsHiveKey,1);
  // List<dynamic> result = await getsoliman(DataBaseConstants.featuerdRecordsHiveKey);
  // print("$result----------");
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp()
     
  ));
}

// Future<void> addsoliman<int>(String path,int item) async {
//   var box = Hive.box<dynamic>(path); // تأكد من أن الصندوق معرف بنوع T
//    box.add(item);
// }
// Future<List<int>> getsoliman<int>(String path) async {
//   var box = Hive.box<int>(path); // تأكد من أن الصندوق معرف بنوع T
//   return box.values.toList();
// }
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
