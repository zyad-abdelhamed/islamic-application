import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';


class GetSurahWithTafsirUseCase
    extends BaseUseCaseWithParameters<List<TafsirAyahEntity>, TafsirRequestParams> {
  final BaseQuranRepo _baseQuranRepo;

  GetSurahWithTafsirUseCase({required BaseQuranRepo baseQuranRepo})
      : _baseQuranRepo = baseQuranRepo;

  @override
  Future<Either<Failure, List<TafsirAyahEntity>>> call(
      {required TafsirRequestParams parameters}) async {
    return await _baseQuranRepo.getSurahWithTafsir(parameters);
  }
}
