import 'package:flutter_exit_app/flutter_exit_app.dart';

abstract class BaseExitAppService {
  Future exitApp();
}

class ExitAppServiceImplByFlutterExitA implements BaseExitAppService {
  @override
  Future exitApp() async => await FlutterExitApp.exitApp();
}
