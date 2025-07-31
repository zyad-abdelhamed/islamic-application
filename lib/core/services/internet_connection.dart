import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetConnection {
  Future<bool> checkInternetConnection();
  Future<void> openInternetSettings() async {
  AppSettings.openAppSettings(type: AppSettingsType.wifi); 
  
}
Stream<bool> get onInternetStatusChanged;
}

class InternetConnectionImpl extends InternetConnection {
  @override
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  
  @override
  // TODO: implement onInternetStatusChanged
  Stream<bool> get onInternetStatusChanged => throw UnimplementedError();
  
 
  
}

class InternetConnectionImpl2 extends InternetConnection {
  final InternetConnectionChecker checker =
      InternetConnectionChecker.createInstance();

  @override
  Future<bool> checkInternetConnection() async {
    return await checker.hasConnection;
  }
  
  @override
  Stream<bool> get onInternetStatusChanged =>
      checker.onStatusChange.map((status) {
        return status == InternetConnectionStatus.connected;
      });
}
