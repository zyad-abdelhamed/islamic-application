import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/presentation/controller/cubit/location_cubit.dart';

class SaveOrUpdateLocationWidget extends StatefulWidget {
  const SaveOrUpdateLocationWidget({
    super.key,
    required this.functionaltiy,
    required this.buttonName,
  });
  final Functionaltiy functionaltiy;
  final String buttonName;

  @override
  State<SaveOrUpdateLocationWidget> createState() =>
      _SaveOrUpdateLocationWidgetState();
}

enum Functionaltiy { save, update }

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
         Text(
          'يرجى التأكد من تفعيل الإنترنت والموقع لكي تتمكن من ${widget.buttonName}.',
          style: TextStyle(fontFamily: "dataFontFamily"),
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
                          isConnectedNotifier.value
                              ? Icons.wifi
                              : Icons.wifi_off,
                          color: isConnectedNotifier.value
                              ? AppColors.successColor
                              : AppColors.errorColor,
                        ),
                        Text(
                          isConnectedNotifier.value
                              ? "متصل بالإنترنت"
                              : "لا يوجد اتصال بالإنترنت",
                          style: TextStyle(
                            fontSize: 16,
                            color: isConnectedNotifier.value
                                ? AppColors.successColor
                                : AppColors.errorColor,
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
                        ? AppColors.successColor
                        : AppColors.errorColor,
                  ),
                  Text(
                    isLocationEnabledNotifier.value
                        ? "الموقع مفعّل"
                        : "الموقع غير مفعّل",
                    style: TextStyle(
                      fontSize: 16,
                      color: isLocationEnabledNotifier.value
                          ? AppColors.successColor
                          : AppColors.errorColor,
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
                    ? () {
                        final cubit = context.read<LocationCubit>();
                        switch (widget.functionaltiy) {
                          case Functionaltiy.save:
                            cubit.saveLocationRequest(context);
                            break;
                          case Functionaltiy.update:
                            cubit.updateLocationRequest(context);
                            break;
                        }
                      }
                    : null,
                disabledColor: Colors.grey,
                color: Theme.of(context).primaryColor,
                child: BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: state.requestState == RequestStateEnum.loading
                            ? Row(
                                spacing: 5,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("يتم ${widget.buttonName} ..."),
                                  GetAdaptiveLoadingWidget(),
                                ],
                              )
                            : Text(
                                widget.buttonName,
                                style: TextStyle(color: AppColors.white),
                              ));
                  },
                ))),
      ],
    );
  }
}