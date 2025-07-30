import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/models/location_model.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';

abstract class BaseLocationRepo {
  Future<Either<Failure, LocationEntity?>> getCurrentLocation();
  Future<Either<Failure, Unit>> updateLocation();
  Future<Either<Failure, Unit>> saveLocation({required LocationModel location});
}
