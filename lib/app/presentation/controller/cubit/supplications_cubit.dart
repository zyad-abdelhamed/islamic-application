import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';

part 'supplications_state.dart';

class SupplicationsCubit extends Cubit<SupplicationsState> {
  final GetAdhkarUseCase getAdhkarUseCase;
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  SupplicationsCubit(this.getAdhkarUseCase) : super(SupplicationsState());
  //switch
  void toggleIsDeletedSwitch() {
    if (state.isDeleted) {
      emit(state.copyWith(isDeleted: false));
    } else {
      emit(state.copyWith(isDeleted: true));
    }
  }

  //animation
  void removeItemFromListAnimation() {
    animatedListKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 500));
    emit(SupplicationsState());
  }

  //supplications events
  void getAdhkar(AdhkarParameters adhkarParameters) async {
    Either<Failure, List<AdhkarEntity>> result = await getAdhkarUseCase(parameters: adhkarParameters);

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
          adhkar: data,
        ));
      },
    );
  }

  void decreaseCount({required int index,required int count}) {
    if (state.index == index) {
  if (count != 0) {
    emit(state.copyWith(
        opacity: 0.0, offset: Offset(0, .3))); //start animation
  
    Future.delayed(ViewConstants.duration, () {
      count--; //decrease count
      emit(state.copyWith(opacity: 1.0, offset: Offset.zero,index: index));
    }); //reverse animation and stop
  }
}
  }
}
