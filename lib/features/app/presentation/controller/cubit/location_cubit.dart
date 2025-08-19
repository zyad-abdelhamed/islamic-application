import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.locationRepo) : super(LocationState());

  final BaseLocationRepo locationRepo;

  void updateLocationRequest(BuildContext context) async {
    emit(LocationState(requestState: RequestStateEnum.loading));
    final result = await locationRepo.updateLocation();
    result.fold((l) {
      AppSnackBar(
        message: l.message,
        type: AppSnackBarType.error,
      ).show(context);
      emit(LocationState(requestState: RequestStateEnum.failed));
    }, (r) {
      AppSnackBar(
        message: 'تم تحديث الموقع',
        type: AppSnackBarType.success,
      ).show(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesConstants.splashScreenRouteName,
        (_) => false,
      );
    });
  }

  void saveLocationRequest(BuildContext context) async {
    emit(LocationState(requestState: RequestStateEnum.loading));
    final result = await locationRepo.saveLocation();
    result.fold((l) {
      AppSnackBar(message: l.message, type: AppSnackBarType.error)
          .show(context);
      emit(LocationState(requestState: RequestStateEnum.failed));
    }, (r) {
      AppSnackBar(message: 'تم حفظ الموقع', type: AppSnackBarType.success)
          .show(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesConstants.splashScreenRouteName,
        (_) => false,
      );
    });
  }
}
