import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.locationRepo) : super(LocationState());

  final BaseLocationRepo locationRepo;

  static LocationCubit controller(BuildContext context) =>
      context.read<LocationCubit>();

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
}
