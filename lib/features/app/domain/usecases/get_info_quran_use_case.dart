import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class GetInfoQuranUseCase
    extends BaseUseCaseWithoutParameters<List<SurahEntity>> {
  final BaseQuranRepo baseQuranRepo;
  GetInfoQuranUseCase(this.baseQuranRepo);
  @override
  Future<Either<Failure, List<SurahEntity>>> call() async {
    return await baseQuranRepo.getSurahsInfo();
  }
}
