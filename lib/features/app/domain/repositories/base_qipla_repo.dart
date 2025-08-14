import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/qipla_entity.dart';

abstract class BaseQiblaRepository {
  Stream<Either<Failure, QiblaEntity>> listenToQibla(LocationAccuracy accuracy);
}
