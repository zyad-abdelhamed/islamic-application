import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/services/position_service.dart';

part 'qibla_state.dart';
class QiblaCubit extends Cubit<QiblaState> {
  QiblaCubit(this.basePositionService) : super(QiblaInitial());

  StreamSubscription<CompassEvent>? _compassSubscription;
  final BasePositionService basePositionService;

  Future<void> initQibla() async {
    try {
      emit(QiblaLoading());

      
      if (!await basePositionService.isServiceEnabled) {
        emit(QiblaError('GPS غير مفعل'));
        return;
      }

      if (await basePositionService.checkPermission == LocationPermission.denied) {
        if (await basePositionService.requestPermission == LocationPermission.denied) {
          emit(QiblaError('تم رفض صلاحية الموقع'));
          return;
        }
      }

      final Position position = await basePositionService.position;
      final qiblaDir = _calculateQiblaDirection(position.latitude, position.longitude);

      _compassSubscription = FlutterCompass.events!.listen((event) {
        final heading = event.heading;
        if (heading != null) {
          emit(QiblaLoaded(
            deviceDirection: heading,
            qiblaDirection: qiblaDir,
          ));
        }
      });
    } catch (e) {
      emit(QiblaError('حدث خطأ: $e'));
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

  @override
  Future<void> close() {
    _compassSubscription?.cancel();
    return super.close();
  }
}
