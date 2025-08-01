import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/services/city_name_service.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/features/app/data/datasources/location_local_data_source.dart';
import 'package:test_app/features/app/data/models/location_model.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';

class LocationRepo extends BaseLocationRepo {
  final BaseLocationLocalDataSource baseLocationLocalDataSource;
  final LocationNameService locationNameService;
  final InternetConnection internetConnection;
  final BaseLocationService baseLocationService;
  LocationRepo(this.baseLocationLocalDataSource, this.locationNameService,
      this.internetConnection, this.baseLocationService);
  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    try {
      LocationEntity? locationEntity =
          await baseLocationLocalDataSource.getLocationFromLocalDataSource();
      if (locationEntity != null) {
        return Right(locationEntity);
      } else {
        return const Left(
            Failure(AppStrings.deniedLocationPermissionAlertDialogText));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLocation({LocationModel? location}) async {
    bool isOnline = await internetConnection.checkInternetConnection();
    bool isLocationEnabled = await baseLocationService.isServiceEnabled;
    if (isOnline && isLocationEnabled) {
      try {
        final Position position = await baseLocationService.position;
        final String city =
            await locationNameService.getCityNameFromCoordinates(
          position.latitude,
          position.longitude,
        );
        await baseLocationLocalDataSource.saveLocationLocaly(
          LocationModel(
            latitude: position.latitude,
            longitude: position.longitude,
            name: city,
          ),
        );

        return Right(unit);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('يرجى التأكد من الاتصال بالإنترنت وتفعيل الموقع.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLocation() async {
    try {
      bool isOnline = await internetConnection.checkInternetConnection();
      bool isLocationEnabled = await baseLocationService.isServiceEnabled;

      if (isOnline && isLocationEnabled) {
        final Position position = await baseLocationService.position;
        final String city =
            await locationNameService.getCityNameFromCoordinates(
          position.latitude,
          position.longitude,
        );
        await saveLocation(
          location: LocationModel(
            latitude: position.latitude,
            longitude: position.longitude,
            name: city,
          ),
        );

        return Right(unit);
      } else {
        return Left(Failure('يرجى التأكد من الاتصال بالإنترنت وتفعيل الموقع.'));
      }
    } catch (e) {
      return Left(Failure('حدث خطأ أثناء تحديث الموقع: ${e.toString()}'));
    }
  }
}
