import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';

class LocationFunctionalityController {
  late final ValueNotifier<bool> isConnectedNotifier;
  late final ValueNotifier<bool> isLocationEnabledNotifier;

  late StreamSubscription<bool> internetSubscription;
  late StreamSubscription<bool> locationEnabledSubscription;

  void initState(bool isConnected, isLocationEnabled) {
    isConnectedNotifier = ValueNotifier<bool>(isConnected);
    isLocationEnabledNotifier = ValueNotifier<bool>(isLocationEnabled);
    // متابعة اتصال الإنترنت
    internetSubscription =
        sl<InternetConnection>().onInternetStatusChanged.listen((connected) {
      isConnectedNotifier.value = connected;
    });

    // متابعة حالة الموقع (مفعّل أم لا)
    locationEnabledSubscription = sl<BaseLocationService>()
        .isLocationServiceEnabledStream
        .listen((enabled) {
      isLocationEnabledNotifier.value = enabled;
    });
  }

  void dispose() {
    internetSubscription.cancel();
    locationEnabledSubscription.cancel();
    isConnectedNotifier.dispose();
    isLocationEnabledNotifier.dispose();
  }
}