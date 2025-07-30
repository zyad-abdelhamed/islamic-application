import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/duaa/domain/entities/duaa_entity.dart';
import 'package:test_app/features/duaa/domain/repos/duaa_base_repo.dart';

part 'duaa_state.dart';

class DuaaCubit extends Cubit<DuaaState> {
  DuaaCubit(this.duaaBaseRepo) : super(DuaaState());
  final DuaaBaseRepo duaaBaseRepo;
  getDuaa() async {
    final result = await duaaBaseRepo.getDuaaWithPegnation();
    result.fold((l) {
      emit(DuaaState(
          duaaErrorMessage: l.message,
          duaaRequestState: RequestStateEnum.failed));
    }, (r) {
      emit(DuaaState(duaas: r, duaaRequestState: RequestStateEnum.success));
    });
  }
}
