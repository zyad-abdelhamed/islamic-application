import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';

class LocatioPermissionController {
  ValueNotifier<LocationPermission> permissionStatusNotifier =
      ValueNotifier<LocationPermission>(LocationPermission.denied);
  late StreamSubscription<LocationPermission> permissionSubscription;

  void initState() {
    permissionSubscription =
        sl<BaseLocationService>().locationPermissionStream.listen((perm) {
      permissionStatusNotifier.value = perm;
    });
  }

  void dispose() {
    permissionSubscription.cancel();
    permissionStatusNotifier.dispose();
  }

  bool get shouldShowLocationButton {
    return permissionStatusNotifier.value != LocationPermission.always &&
        permissionStatusNotifier.value != LocationPermission.whileInUse;
  }

  Future<Map<String, bool>> fetchLocationData() async {
    final bool isConnected =
        await sl<InternetConnection>().checkInternetConnection();
    final bool isEnabled = await sl<BaseLocationService>().isServiceEnabled;
    return {
      "isConnected": isConnected,
      "isServiceEnabled": isEnabled,
    };
  }
}
