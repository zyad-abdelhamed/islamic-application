import 'dart:async';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/app_colors.dart';

class SaveOrUpdateLocationWidget extends StatefulWidget {
  const SaveOrUpdateLocationWidget({
    super.key,
    required this.buttonFunction,
    required this.buttonName,
  });
  final VoidCallback buttonFunction;
  final String buttonName;

  @override
  State<SaveOrUpdateLocationWidget> createState() =>
      _SaveOrUpdateLocationWidgetState();
}

class _SaveOrUpdateLocationWidgetState
    extends State<SaveOrUpdateLocationWidget> {
  final ValueNotifier<bool> isConnectedNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isLocationEnabledNotifier =
      ValueNotifier<bool>(true);

  late StreamSubscription<bool> internetSubscription;
  late StreamSubscription<bool> locationEnabledSubscription;

  @override
  void initState() {
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
    super.initState();
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    locationEnabledSubscription.cancel();
    isConnectedNotifier.dispose();
    isLocationEnabledNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'يرجى التأكد من تفعيل الإنترنت والموقع لتحديث موقعك الحالي.',
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
           ValueListenableBuilder<bool>(
              valueListenable: isConnectedNotifier,
              builder: (_, __, ___) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(
                  isConnectedNotifier.value ? Icons.wifi : Icons.wifi_off,
                  color: isConnectedNotifier.value
                      ? Colors.blueAccent
                      : AppColors.thirdColor,
                ),
                Text(
                  isConnectedNotifier.value
                      ? "متصل بالإنترنت"
                      : "لا يوجد اتصال بالإنترنت",
                  style: TextStyle(
                    fontSize: 16,
                    color: isConnectedNotifier.value
                        ? Colors.blueAccent
                        : AppColors.thirdColor,
                  ),
                ),
              ],
            )),
            ValueListenableBuilder<bool>(
              valueListenable: isLocationEnabledNotifier,
              builder: (_, __, ___) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Icon(
                    isLocationEnabledNotifier.value
                        ? Icons.location_on
                        : Icons.location_off,
                    color: isLocationEnabledNotifier.value
                        ? Colors.blueAccent
                        : AppColors.thirdColor,
                  ),
                  Text(
                    isLocationEnabledNotifier.value
                        ? "الموقع مفعّل"
                        : "الموقع غير مفعّل",
                    style: TextStyle(
                      fontSize: 16,
                      color: isLocationEnabledNotifier.value
                          ? Colors.blueAccent
                          : AppColors.thirdColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        ListenableBuilder(
            listenable: Listenable.merge(
                <Listenable>[isConnectedNotifier, isLocationEnabledNotifier]),
            builder: (_, __) => MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: (isConnectedNotifier.value &&
                        isLocationEnabledNotifier.value)
                    ? widget.buttonFunction
                    : null,
                disabledColor: Colors.grey,
                color: Theme.of(context).primaryColor,
                child: Text(
                  widget.buttonName,
                  style: TextStyle(color: AppColors.white),
                ))),
      ],
    );
  }
}
