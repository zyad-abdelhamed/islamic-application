import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/save_or_update_location_widget.dart';

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

  @override
  void dispose() {
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 100, color: Theme.of(context).primaryColor),
              SizedBox(height: 20),
              Text(
                AppStrings.activationLocationRequired,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.usesOfActivationLocation,
                style: TextStyles.semiBold16_120(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder<LocationPermission>(
                valueListenable: permissionStatusNotifier,
                builder: (_, __, ___) => Column(
                  children: [
                    Visibility(
                      visible: shouldShowLocationButton,
                      child: Column(
                        spacing: 12,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                sl<BaseLocationService>().requestPermission,
                            child: Text(AppStrings.activationLocationNow),
                          ),
                          TextButton(
                            onPressed:() => 
                              showLocationWarningDialog(context),
                            child: Text("لاحقاً"),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !shouldShowLocationButton,
                      child: SaveOrUpdateLocationWidget(
                        buttonFunction: () {},
                        buttonName: AppStrings.saveLocation,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showLocationWarningDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('تنبيه هام'),
      content: Text(
        AppStrings.deniedLocationPermissionAlertDialogText,
        textAlign: TextAlign.right,
        style: TextStyle(height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesConstants.splashScreenRouteName,
              (_) => false,
            );
          },
          child: Text(AppStrings.gotIt),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}
