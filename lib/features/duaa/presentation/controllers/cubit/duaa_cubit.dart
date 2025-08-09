import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/duaa/domain/entities/duaa_entity.dart';
import 'package:test_app/features/duaa/domain/repos/duaa_base_repo.dart';

part 'duaa_state.dart';

class DuaaCubit extends Cubit<DuaaState> {
  DuaaCubit(this.duaaBaseRepo) : super(DuaaState());

  final DuaaBaseRepo duaaBaseRepo;

  List<DuaaEntity> addDuaa = [];

  getDuaa({required int page}) async {
    emit(DuaaState(duaaRequestState: RequestStateEnum.loading));

    final result = await duaaBaseRepo.getDuaaWithPegnation(page: page);

    result.fold((l) {
      emit(DuaaState(
        duaaErrorMessage: l.message,
        duaaRequestState: RequestStateEnum.failed,
      ));
    }, (r) {
      addDuaa.addAll(r);
      emit(DuaaState(
        duaas: addDuaa,
        duaaRequestState: RequestStateEnum.success,
      ));
    });
  }
}
