import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/features/app/domain/repositories/home_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class GetTodayHadithUseCase extends BaseUseCaseWithoutParameters<Hadith> {
  final BaseHomeRepo baseHomeRepo;
  GetTodayHadithUseCase({required this.baseHomeRepo});
  @override
  Future<Either<Failure, Hadith>> call() async {
    return await baseHomeRepo.getRandomHadith();
  }
}
