import 'package:app_settings/app_settings.dart';
import 'package:geolocator/geolocator.dart';

abstract class BaseLocationService {
  Future<bool> get isServiceEnabled;
  Future<LocationPermission> get checkPermission;
  Future<LocationPermission> get requestPermission;
  Future<Position> get position;
  Future<void> openLocationSettings() async {
    await AppSettings.openAppSettings(type: AppSettingsType.location);
  }
}

class LocatationServiceImplByGeolocator extends BaseLocationService {
  @override
  Future<bool> get isServiceEnabled async =>
      await Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> get checkPermission async =>
      await Geolocator.checkPermission();

  @override
  Future<Position> get position async => await Geolocator.getCurrentPosition();

  @override
  Future<LocationPermission> get requestPermission async =>
      await Geolocator.requestPermission();
}
