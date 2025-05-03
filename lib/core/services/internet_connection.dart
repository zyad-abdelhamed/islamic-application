import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetConnection {
  Future<bool> checkInternetConnection();
}

class InternetConnectionImpl extends InternetConnection{
  @override
  Future<bool> checkInternetConnection()async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}