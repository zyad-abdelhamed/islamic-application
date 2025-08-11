import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/location_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/save_or_update_location_widget.dart';
import 'package:test_app/features/app/presentation/view/components/show_location_warning%20_dialog.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_cubit.dart';

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
late OnBoardingCubit _onBoardingCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onBoardingCubit = context.read<OnBoardingCubit>();
  }
  @override
  void dispose() {
     _onBoardingCubit.emitToTrue();
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
              Icon(Icons.location_on,
                  size: 100, color: Theme.of(context).primaryColor),
              SizedBox(height: 20),
              Text(
                AppStrings.translate("activationLocationRequired"),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.translate("usesOfActivationLocation"),
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
                            onPressed: () async =>
                                await sl<BaseLocationService>().requestPermission(),
                            child: Text(AppStrings.translate("activationLocationNow")),
                          ),
                          TextButton(
                            onPressed: () => showLocationWarningDialog(context),
                            child: Text("لاحقاً"),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !shouldShowLocationButton,
                      child: BlocProvider(
                        create: (context) => sl<LocationCubit>(),
                        child: SaveOrUpdateLocationWidget(
                          functionaltiy: Functionaltiy.save,
                          buttonName: AppStrings.translate("saveLocation"),
                        ),
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