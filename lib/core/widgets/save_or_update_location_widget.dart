import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/controllers/location_functionality_controller.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/enums.dart';
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
  late final LocationFunctionalityController _Controller;

  @override
  void initState() {
    _Controller = LocationFunctionalityController();
    _Controller.initState(widget.isConnected, widget.isLocationEnabled);
    super.initState();
  }

  @override
  void dispose() {
    _Controller.dispose();
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
              valueListenable: _Controller.isConnectedNotifier,
              builder: (_, __, ___) => isServiceEnabledWidget(
                  isActive: _Controller.isConnectedNotifier.value,
                  activeIcon: Icons.wifi,
                  inactiveIcon: Icons.wifi_off,
                  activeText: "متصل بالإنترنت",
                  inactiveText: "لا يوجد اتصال بالإنترنت"),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _Controller.isLocationEnabledNotifier,
              builder: (_, __, ___) => isServiceEnabledWidget(
                  isActive: _Controller.isLocationEnabledNotifier.value,
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
              _Controller.isConnectedNotifier,
              _Controller.isLocationEnabledNotifier
            ]),
            builder: (_, __) => MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: (_Controller.isConnectedNotifier.value &&
                        _Controller.isLocationEnabledNotifier.value)
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
