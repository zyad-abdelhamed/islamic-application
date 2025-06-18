import 'package:geolocator/geolocator.dart';

abstract class BaseLocatationService {
  Future<bool> get isServiceEnabled;
  Future<LocationPermission> get checkPermission;
  Future<LocationPermission> get requestPermission;
  Future<Position> get position;
}

class LocatationServiceImplByGeolocator extends BaseLocatationService {
  @override
  Future<bool> get isServiceEnabled async=> await Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> get checkPermission async=> await Geolocator.checkPermission();

  @override
  Future<Position> get position async=> await Geolocator.getCurrentPosition();
  
  @override
  Future<LocationPermission> get requestPermission async=> await Geolocator.requestPermission();
 
}