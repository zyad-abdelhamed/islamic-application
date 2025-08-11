import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class LocationNameService {
  Future<Either<Failure, String>> getCityNameFromCoordinates(
      double latitude, double longitude);
}

class LocationNameServiceImpl extends LocationNameService {
  @override
  Future<Either<Failure, String>> getCityNameFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return right(place.locality ??
            place.administrativeArea ??
            AppStrings.translate("unknownCity"));
      } else {
        return right(AppStrings.translate("unknownCity"));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
