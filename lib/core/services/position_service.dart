import 'dart:async';

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

  Stream<bool> get isLocationServiceEnabledStream;
  Stream<LocationPermission> get locationPermissionStream;
}

class LocatationServiceImplByGeolocator extends BaseLocationService {
  final StreamController<bool> _serviceStatusController =
      StreamController<bool>.broadcast();
  final StreamController<LocationPermission> _permissionStatusController =
      StreamController<LocationPermission>.broadcast();

  LocatationServiceImplByGeolocator() {
    // تابع حالة تفعيل الخدمة (GPS)
    Timer.periodic(Duration(seconds: 2), (_) async {
      bool enabled = await Geolocator.isLocationServiceEnabled();
      _serviceStatusController.add(enabled);
    });

    // تابع حالة الإذن
    Timer.periodic(Duration(seconds: 2), (_) async {
      LocationPermission permission = await Geolocator.checkPermission();
      _permissionStatusController.add(permission);
    });
  }

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

  @override
  Stream<bool> get isLocationServiceEnabledStream =>
      _serviceStatusController.stream;

  @override
  Stream<LocationPermission> get locationPermissionStream =>
      _permissionStatusController.stream;
}
