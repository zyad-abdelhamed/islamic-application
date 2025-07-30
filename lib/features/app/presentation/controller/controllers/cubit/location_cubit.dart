import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';
import 'package:test_app/features/app/presentation/view/components/show_location_dialog.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.locationRepo) : super(LocationState());
  final BaseLocationRepo locationRepo;
  Future<void> updateLocationRequest(BuildContext context) async {
    emit(LocationState(updateRequestState: RequestStateEnum.loading));
    final result = await locationRepo.updateLocation();
    result.fold((l) {
      appSneakBar(context: context, message: l.message, isError: true);
      emit(LocationState(updateRequestState: RequestStateEnum.failed));
    }, (r) {
      appSneakBar(context: context, message: 'تم تحديث الموقع', isError: false);
      emit(LocationState(updateRequestState: RequestStateEnum.success));
    });
  }

  updateLocation(BuildContext context) async {
    bool isLocationEnabled = await sl<BaseLocationService>().isServiceEnabled;
    bool isOnline = await sl<InternetConnection>().checkInternetConnection();
    showLocationUpdateDialog(
        context: context,
        isOnline: isOnline,
        isLocationEnabled: isLocationEnabled,
        onOpenInternet: () => sl<InternetConnection>().openInternetSettings(),
        onOpenLocation: () => sl<BaseLocationService>().openLocationSettings(),
        onUpdateLocation: () => updateLocationRequest(context));
  }
}
