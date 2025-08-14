import 'dart:async';
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/features/app/domain/entities/qipla_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_qipla_repo.dart';

class QiblaRepository implements BaseQiblaRepository {
  final BaseLocationService locationService;

  QiblaRepository(this.locationService);
  
  @override
  Stream<Either<Failure, QiblaEntity>> listenToQibla(LocationAccuracy accuracy) async* {
  try {
    final position = await locationService.getPositionWithAccuracy(accuracy);
    final qiblaDir = _calculateQiblaDirection(
      position.latitude,
      position.longitude,
    );

    yield* FlutterCompass.events!.map((event) {
      if (event.heading == null) {
        return Left(Failure('تعذر الحصول على اتجاه الجهاز'));
      }
      return Right(QiblaEntity(
        deviceDirection: event.heading!,
        qiblaDirection: qiblaDir,
      ));
    });
  } catch (e) {
   if (await locationService.checkPermission == LocationPermission.denied) {
        yield Left(Failure('تم رفض صلاحية الموقع'));
      } else if (!await locationService.isServiceEnabled) {
        yield Left(Failure('GPS غير مفعل'));
      } else {
        yield Left(Failure(e.toString()));
      }
  }
}

  double _calculateQiblaDirection(double lat, double lon) {
    const double kaabaLat = 21.4225;
    const double kaabaLon = 39.8262;

    double dLon = (kaabaLon - lon) * pi / 180;
    double y = sin(dLon) * cos(kaabaLat * pi / 180);
    double x = cos(lat * pi / 180) * sin(kaabaLat * pi / 180) -
        sin(lat * pi / 180) * cos(kaabaLat * pi / 180) * cos(dLon);
    double direction = atan2(y, x) * 180 / pi;

    return (direction + 360) % 360;
  }
}
