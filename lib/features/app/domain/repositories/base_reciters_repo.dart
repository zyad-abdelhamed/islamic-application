import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';

abstract class BaseRecitersRepo {
  Future<Either<Failure, List<ReciterEntity>>> getReciters();
}
