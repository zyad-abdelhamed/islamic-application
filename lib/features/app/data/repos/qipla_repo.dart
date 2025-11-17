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

  // فلتر الحركة (Exponential moving average)
  double _ema = double.nan;
  final double _alpha;

  // حلقة لتقدير تشويش الحساس - ناخد آخر N قراءة
  final int _bufferSize;
  final List<double> _recent = [];

  QiblaRepository(
    this.locationService, {
    double alpha = 0.12,
    int bufferSize = 8,
  })  : _alpha = alpha,
        _bufferSize = bufferSize;

  @override
  Stream<Either<Failure, QiblaEntity>> listenToQibla(
      LocationAccuracy accuracy) async* {
    try {
      final position = await locationService.getPositionWithAccuracy(accuracy);
      final double qiblaDir =
          _calculateQiblaDirection(position.latitude, position.longitude);

      if (await locationService.checkPermission == LocationPermission.denied) {
        yield Left(Failure('تم رفض صلاحية الموقع'));
        return;
      }
      if (!await locationService.isServiceEnabled) {
        yield Left(Failure('GPS غير مفعل'));
        return;
      }

      final compassStream =
          FlutterCompass.events?.where((e) => e.heading != null);
      if (compassStream == null) {
        yield Left(Failure('غير قادر على الوصول إلى حساس البوصلة'));
        return;
      }

      await for (final event in compassStream) {
        try {
          final raw = event.heading!;

          // نضيف القراءة للحلقة ونحسب الانحراف المعيارى
          _addRecent(raw);
          final std = _stdRecent();

          // اذا كانت التغيّرات كبيرة جداً، نطلب معايرة
          if (std > 15) {
            yield Left(Failure(
                'القراءات غير مستقرة، رجاءً حرّك الجهاز بشكل رقم 8 أو بعدّه عن المعادن'));
            continue;
          }

          // فلترة سريعة (EMA)
          final deviceDir = _smooth(raw);

          // انشئ الكيان وارسله
          yield Right(QiblaEntity(
              deviceDirection: deviceDir, qiblaDirection: qiblaDir));
        } catch (e) {
          yield Left(Failure(e.toString()));
        }
      }
    } catch (e) {
      try {
        if (await locationService.checkPermission ==
            LocationPermission.denied) {
          yield Left(Failure('تم رفض صلاحية الموقع'));
        } else if (!await locationService.isServiceEnabled) {
          yield Left(Failure('GPS غير مفعل'));
        } else {
          yield Left(Failure(e.toString()));
        }
      } catch (_) {
        yield Left(Failure('حدث خطأ أثناء التحقق من صلاحيات الموقع'));
      }
    }
  }

  // ----- Helpers -----
  double _smooth(double newValue) {
    if (_ema.isNaN) {
      _ema = newValue;
      return _ema;
    }
    // تعامُل دائرى مع الزوايا: نحسب الفرق الأقصر بين الزاويتين
    double diff = _angleDiff(newValue, _ema);
    _ema = (_ema + _alpha * diff) % 360;
    if (_ema < 0) _ema += 360;
    return _ema;
  }

  void _addRecent(double v) {
    if (_recent.length >= _bufferSize) _recent.removeAt(0);
    _recent.add(v);
  }

  double _stdRecent() {
    if (_recent.length < 2) return 0.0;
    // حساب متوسط دائرى بسيط: نحول لواحدات x,y
    double sx = 0, sy = 0;
    for (final a in _recent) {
      final r = a * pi / 180;
      sx += cos(r);
      sy += sin(r);
    }
    final mx = sx / _recent.length;
    final my = sy / _recent.length;
    final R = sqrt(mx * mx + my * my);
    // انحراف معادل (تقريبى) بالدرجات
    final stdDeg = sqrt(-2 * log(max(1e-9, R))) * 180 / pi;
    return stdDeg;
  }

  double _angleDiff(double a, double b) {
    double diff = (a - b + 540) % 360 - 180; // في المجال -180..180
    return diff;
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
