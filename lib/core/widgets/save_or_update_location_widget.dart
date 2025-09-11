import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/controllers/location_functionality_controller.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/widgets/app_functionalty_button.dart';
import 'package:test_app/core/widgets/is_service_enabled_widget.dart';
import 'package:test_app/features/app/presentation/controller/cubit/location_cubit.dart';

class SaveOrUpdateLocationWidget extends StatefulWidget {
  const SaveOrUpdateLocationWidget({
    super.key,
    required this.functionaltiy,
    required this.buttonName,
    required this.isConnected,
    required this.isLocationEnabled,
  });
  final Functionaltiy functionaltiy;
  final String buttonName;
  final bool isConnected, isLocationEnabled;

  @override
  State<SaveOrUpdateLocationWidget> createState() =>
      _SaveOrUpdateLocationWidgetState();
}

enum Functionaltiy { save, update }

class _SaveOrUpdateLocationWidgetState
    extends State<SaveOrUpdateLocationWidget> {
  late final LocationFunctionalityController _controller;

  @override
  void initState() {
    _controller = LocationFunctionalityController();
    _controller.initState(widget.isConnected, widget.isLocationEnabled);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _controller.isConnectedNotifier,
              builder: (_, __, ___) => isServiceEnabledWidget(
                  isActive: _controller.isConnectedNotifier.value,
                  activeIcon: Icons.wifi,
                  inactiveIcon: Icons.wifi_off,
                  activeText: "متصل بالإنترنت",
                  inactiveText: "لا يوجد اتصال بالإنترنت"),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _controller.isLocationEnabledNotifier,
              builder: (_, __, ___) => isServiceEnabledWidget(
                  isActive: _controller.isLocationEnabledNotifier.value,
                  activeIcon: Icons.location_on,
                  inactiveIcon: Icons.location_off,
                  activeText: "الموقع مفعّل",
                  inactiveText: "الموقع غير مفعّل"),
            )
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        ListenableBuilder(
            listenable: Listenable.merge(<Listenable>[
              _controller.isConnectedNotifier,
              _controller.isLocationEnabledNotifier
            ]),
            builder: (_, __) =>
                AppFunctionaltyButton<LocationCubit, LocationState>(
                  buttonName: widget.buttonName,
                  onPressed: (_controller.isConnectedNotifier.value &&
                          _controller.isLocationEnabledNotifier.value)
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
                  isLoading: (state) =>
                      state.requestState == RequestStateEnum.loading,
                  disabled: !(_controller.isConnectedNotifier.value &&
                      _controller.isLocationEnabledNotifier.value),
                )),
      ],
    );
  }
}
