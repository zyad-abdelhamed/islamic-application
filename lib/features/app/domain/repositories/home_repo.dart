import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/domain/entities/duaa_entity.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseHomeRepo {
  Future<Either<Failure, List<AdhkarEntity>>> getAdhkar(
      {required AdhkarParameters adhkarParameters});
  Future<Either<Unit, Hadith>> getRandomHadith();
  Future<Either<Failure, List<DuaaEntity>>> getDuaaWithPegnation();    
}
