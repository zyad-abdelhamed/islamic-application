import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetConnection {
  Future<bool> checkInternetConnection();
}

class InternetConnectionImpl extends InternetConnection {
  @override
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

class InternetConnectionImpl2 extends InternetConnection {
  final InternetConnectionChecker checker =
      InternetConnectionChecker.createInstance();

  @override
  Future<bool> checkInternetConnection() async {
    return await checker.hasConnection;
  }
}
