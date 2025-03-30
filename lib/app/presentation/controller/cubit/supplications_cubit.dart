import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/utils/enums.dart';

part 'supplications_state.dart';

class SupplicationsCubit extends Cubit<SupplicationsState> {
  final GetAdhkarUseCase getAdhkarUseCase;
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  SupplicationsCubit(this.getAdhkarUseCase) : super(SupplicationsState());
  //switch
  bool _isDeleted = false;
  bool get isDeleted => _isDeleted;
  set isDeleted(bool isDeleted) {
    _isDeleted = isDeleted;
    emit(state.copyWith());
  }

  void toggleIsDeletedSwitch() {
    _isDeleted ? isDeleted = false : isDeleted = true;
  }

  void removeItemFromListAnimation() {
    animatedListKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 500));
    emit(SupplicationsState());
  }

  //supplications events
  void getAdhkar(AdhkarParameters adhkarParameters) async {
    print('=================');
    var result = await getAdhkarUseCase(parameters: adhkarParameters);
    result.fold((l) => SupplicationsState(
      adhkarRequestState: RequestStateEnum.failed,
      adhkarErorrMessage: l.message
    ), (r) => SupplicationsState(
      adhkarRequestState: RequestStateEnum.success,
      adhkar: r
    ));
  }

  void decreaseCount({required int index}) {
    int count = 0;
    // wordsm[index]["num"];
    if (count != 0) {
      emit(SupplicationsState(
          opacity: 0.0, offset: Offset(0, .3))); //start animation

      Future.delayed(ViewConstants.duration, () {
        count--; //decrease count
        emit(SupplicationsState(opacity: 1.0, offset: Offset.zero));
      }); //reverse animation and stop
    }
  }
}
