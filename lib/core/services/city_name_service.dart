import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


abstract class LocationNameService {
  Future<String> getCityNameFromCoordinates(double latitude, double longitude);

  /// ترجع اسم المدينة الحالي بناءً على الموقع، أو "القاهرة" في حالة الخطأ أو رفض الإذن
  Future<String> getCityNameOrDefault({
    double defaultLat = 30.0444,   // القاهرة
    double defaultLng = 31.2357,
  });
}



class LocationNameServiceImpl extends LocationNameService {
  @override
  Future<String> getCityNameFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return place.locality ?? place.administrativeArea ?? "مدينة غير معروفة";
      } else {
        return "مدينة غير معروفة";
      }
    } catch (e) {
      return "خطأ: ${e.toString()}";
    }
  }

  @override
  Future<String> getCityNameOrDefault({
    double defaultLat = 30.0444,
    double defaultLng = 31.2357,
  }) async {
    try {
      // التأكد أن الخدمة مفعلة
      final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        return await getCityNameFromCoordinates(defaultLat, defaultLng);
      }

      // التأكد من الصلاحيات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return await getCityNameFromCoordinates(defaultLat, defaultLng);
        }
      }

      // الحصول على الموقع الفعلي
      final position = await Geolocator.getCurrentPosition();

      return await getCityNameFromCoordinates(
          position.latitude, position.longitude);
    } catch (_) {
      return await getCityNameFromCoordinates(defaultLat, defaultLng);
    }
  }
}

