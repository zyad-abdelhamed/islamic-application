import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/usecases/get_info_quran_use_case.dart';

part 'get_surahs_info_state.dart';

class GetSurahsInfoCubit extends Cubit<GetSurahsInfoState> {
  GetSurahsInfoCubit(this.useCase) : super(const GetSurahsInfoState());

  final GetInfoQuranUseCase useCase;

  void getData() async {
    final Either<Failure, List<SurahEntity>> result = await useCase();
    result.fold(
        (l) => GetSurahsInfoState(
              state: RequestStateEnum.failed,
              errorMessage: l.message,
            ),
        (r) => GetSurahsInfoState(
              state: RequestStateEnum.success,
              surahsInfo: r,
            ));
  }
}
