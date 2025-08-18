import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/domain/entities/duaa_entity.dart';
import 'package:test_app/features/app/domain/repositories/home_repo.dart';

part 'duaa_state.dart';

class DuaaCubit extends Cubit<DuaaState> {
  DuaaCubit(this.baseHomeRepo) : super(DuaaState()){
    getDuaa();
  }

  final BaseHomeRepo baseHomeRepo;
  List<DuaaEntity> _allDuaas = [];

  getDuaa() async {
    if (!isClosed) {
      emit(DuaaState(duaaRequestState: RequestStateEnum.loading));
    }
    final result = await baseHomeRepo.getDuaaWithPegnation();

    result.fold((l) {
      if (!isClosed) {
        emit(DuaaState(
          duaaErrorMessage: l.message,
          duaaRequestState: RequestStateEnum.failed,
        ));
      }
    }, (r) {
      _allDuaas = r;
      if (!isClosed) {
        emit(DuaaState(
          duaas: r,
          duaaRequestState: RequestStateEnum.success,
        ));
      }
    });
  }


searchDuaa(String query) {
  if (query.isEmpty) {
    if (!isClosed) {
      emit(DuaaState(
        duaas: _allDuaas,
        duaaRequestState: RequestStateEnum.success,
      ));
    }
    return;
  }

  final filtered = _allDuaas.where((d) {
    final title = d.title.toLowerCase() ;
    final content = d.content.toLowerCase();
    return title.contains(query.toLowerCase()) ||
        content.contains(query.toLowerCase());
  }).toList();

  if (filtered.isEmpty) {
    if (!isClosed) {
      emit(DuaaState(
        duaas: [],
        duaaRequestState: RequestStateEnum.failed,
        duaaErrorMessage: 'لا يوجد أدعية',
      ));
    }
  } else {
    if (!isClosed) {
      emit(DuaaState(
        duaas: filtered,
        duaaRequestState: RequestStateEnum.success,
      ));
    }
  }
}

}

