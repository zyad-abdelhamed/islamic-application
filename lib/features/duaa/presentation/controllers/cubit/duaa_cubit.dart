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

  Future<bool> getDuaa({required int page}) async {
    emit(DuaaState(
      duaas: addDuaa,
      duaaRequestState: RequestStateEnum.loading,
    ));

    final result = await duaaBaseRepo.getDuaaWithPegnation(page: page);
    bool hasData = false;

    result.fold((l) {
      emit(DuaaState(
        duaas: addDuaa,
        duaaErrorMessage: l.message,
        duaaRequestState: RequestStateEnum.failed,
      ));
    }, (r) {
      if (r.isNotEmpty) {
        addDuaa.addAll(r);
        hasData = true;
      }
      emit(DuaaState(
        duaas: addDuaa,
        duaaRequestState: RequestStateEnum.success,
      ));
    });

    return hasData;
  }
}
