import 'package:bloc/bloc.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/duaa/domain/entities/duaa_entity.dart';
import 'package:test_app/features/duaa/domain/repos/duaa_base_repo.dart';

part 'duaa_state.dart';

class DuaaCubit extends Cubit<DuaaState> {
  DuaaCubit(this.duaaBaseRepo) : super(DuaaState());

  final DuaaBaseRepo duaaBaseRepo;
  List<DuaaEntity> _allDuaas = [];

  getDuaa() async {
    emit(DuaaState(duaaRequestState: RequestStateEnum.loading));
    final result = await duaaBaseRepo.getDuaaWithPegnation();

    result.fold((l) {
      emit(DuaaState(
        duaaErrorMessage: l.message,
        duaaRequestState: RequestStateEnum.failed,
      ));
    }, (r) {
      _allDuaas = r;
      emit(DuaaState(
        duaas: r,
        duaaRequestState: RequestStateEnum.success,
      ));
    });
  }


searchDuaa(String query) {
  if (query.isEmpty) {
    emit(DuaaState(
      duaas: _allDuaas,
      duaaRequestState: RequestStateEnum.success,
    ));
    return;
  }

  final filtered = _allDuaas.where((d) {
    final title = d.title.toLowerCase() ;
    final content = d.content.toLowerCase();
    return title.contains(query.toLowerCase()) ||
        content.contains(query.toLowerCase());
  }).toList();

  if (filtered.isEmpty) {
    emit(DuaaState(
      duaas: [],
      duaaRequestState: RequestStateEnum.failed,
      duaaErrorMessage: 'لا يوجد أدعية',
    ));
  } else {
    emit(DuaaState(
      duaas: filtered,
      duaaRequestState: RequestStateEnum.success,
    ));
  }
}

}
