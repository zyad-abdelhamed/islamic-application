import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_controller.dart';
import 'package:test_app/features/onboarding/presentation/view/component/activate_location_permission_column.dart';
import 'package:test_app/features/onboarding/presentation/view/component/save_location_column.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
  ValueNotifier<LocationPermission> permissionStatusNotifier =
      ValueNotifier<LocationPermission>(LocationPermission.denied);
  late StreamSubscription<LocationPermission> permissionSubscription;

  @override
  void initState() {
    super.initState();
    // متابعة حالة تصريح الوصول للموقع
    permissionSubscription =
        sl<BaseLocationService>().locationPermissionStream.listen((perm) {
      permissionStatusNotifier.value = perm;
    });
  }

  late final OnBoardingController _onBoardingController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onBoardingController = sl<OnBoardingController>();
  }

  @override
  void dispose() {
    _onBoardingController.markAsDisplayed();
    permissionSubscription.cancel();
    permissionStatusNotifier.dispose();
    super.dispose();
  }

  bool get shouldShowLocationButton {
    return permissionStatusNotifier.value != LocationPermission.always &&
        permissionStatusNotifier.value != LocationPermission.whileInUse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder<LocationPermission>(
            valueListenable: permissionStatusNotifier,
            builder: (_, __, ___) => AnimatedSwitcher(
              duration: AppDurations.mediumDuration,
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Column(
                key: ValueKey<bool>(shouldShowLocationButton),
                mainAxisAlignment: MainAxisAlignment.center,
                children: shouldShowLocationButton
                    ? activateLocationPermissionColumn(context)
                    : saveLocationColumn(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
