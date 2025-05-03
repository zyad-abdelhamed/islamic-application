import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';

part 'supplications_state.dart';

class AdhkarCubit extends Cubit<AdhkarState> {
  final GetAdhkarUseCase getAdhkarUseCase;
  final ScrollController supplicationsScrollController = ScrollController();
  AdhkarCubit(this.getAdhkarUseCase) : super(AdhkarState()) {
    supplicationsScrollController.addListener(() {
      emit(state.copyWith(
        progress: supplicationsScrollController.position.pixels));

      if(state.adhkarWidgetsMaintainingSize?.every((element) => element == false) ?? false) ;   
    });
  }

  //supplications events
  void toggleIsDeletedSwitch() {
    if (state.isDeleted) {
      emit(state.copyWith(isDeleted: false));
    } else {
      emit(state.copyWith(isDeleted: true));
    }
  }

  void getAdhkar(AdhkarParameters adhkarParameters) async {
    Either<Failure, List<AdhkarEntity>> result =
        await getAdhkarUseCase(parameters: adhkarParameters);

    result.fold(
      (failure) {
        emit(state.copyWith(
          adhkarRequestState: RequestStateEnum.failed,
          adhkarErorrMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          adhkarRequestState: RequestStateEnum.success,
          adhkarWidgetsOffsets: List.filled(data.length, Offset.zero),
          adhkarWidgetsMaintainingSize: List.filled(data.length, true),
          adhkarcounts: List.generate(
            data.length,
            (index) => data[index].count,
          ),
          adhkar: data,
        ));
      },
    );
  }

  void decreaseCount({required int index}) {
    if (state.adhkarcounts[index] > 1 ||
        (state.adhkarcounts[index] == 1 && !state.isDeleted)) {
      _slideAnimation(index);
    } else if (state.adhkarcounts[index] == 1 && state.isDeleted) {
      _removeAnimation(index);
    }
    return;
  }

  void resetCount({required int index, required int count}) {
    if (state.adhkarcounts[index] == 0) {
      state.adhkarcounts[index] = count;
      emit(state.copyWith(
          selectedIndexOfVisibilty: state.dummyCounterState + 1));
    }
    return;
  }

  //animation
  void _slideAnimation(int index) {
    emit(
        state.copyWith(selectedIndexOfChildAnimation: index)); //start animation

    Future.delayed(AppDurations.lowDuration, () {
      _decreaseCount(index);
      emit(state.copyWith(selectedIndexOfChildAnimation: -1));
    }); //reverse animation and stop
  }

  void _removeAnimation(int index) {
    _decreaseCount(index);
    state.adhkarWidgetsOffsets![index] = Offset(1, 0);
    emit(state.copyWith(selectedIndexOfVisibilty: state.dummyCounterState + 1));
    Future.delayed(AppDurations.mediumDuration, () {
      state.adhkarWidgetsMaintainingSize![index] = false;
      emit(state.copyWith(
          selectedIndexOfVisibilty: state.dummyCounterState + 1));
    });
  }

  //helper functions
  void _decreaseCount(int index) {
    state.adhkarcounts[index]--;
  }
}
