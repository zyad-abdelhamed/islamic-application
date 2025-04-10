import 'package:dartz/dartz.dart';
import 'package:test_app/app/data/datasources/r_table_local_data_source.dart';
import 'package:test_app/app/domain/repositories/r_table_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/models/booleans_model.dart';

class RTableRepo extends BaseRTableRepo {
  final RTableLocalDataSource rTableLocalDataSource;
  RTableRepo({required this.rTableLocalDataSource});
  @override
  Future<Either<Failure, List<bool>>> getBooleans() async {
    try {
      List<bool> result = await rTableLocalDataSource.getBooleans();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetBooleans(
      {required BooleansParameters parameters}) async {
    try {
      await rTableLocalDataSource.resetBooleans(parameters: parameters);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBooleans(
      {required BooleansParameters parameters}) async {
    try {
      rTableLocalDataSource.updateBooleans(parameters: parameters);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
