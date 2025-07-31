import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/data/models/timings_model.dart';
import 'package:test_app/core/constants/api_constants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';

abstract class PrayersRemoteDataSource {
  Future<TimingsModel> getPrayersTimes({required double latitude, required double longitude});
  Future<List<TimingsModel>> getPrayerTimesOfMonth(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters);
}

class PrayersRemoteDataSourceImpl implements PrayersRemoteDataSource {
  final ApiService apiService;
  PrayersRemoteDataSourceImpl(this.apiService);
  @override
  Future<TimingsModel> getPrayersTimes({required double latitude, required double longitude}) async {
    var responseBody = await apiService.get(
        apiServiceInputModel:
            ApiServiceInputModel(url:  Apiconstants.getTimingsUrl(latitude: latitude, longitude: longitude)));

    return TimingsModel.fromJson(responseBody['data']);
  }

  @override
  Future<List<TimingsModel>> getPrayerTimesOfMonth(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters) async{
    var responseBody = await apiService.get(
        apiServiceInputModel:
            ApiServiceInputModel(url: await Apiconstants.getTimingsOfMonthUrl(getPrayerTimesOfMonthPrameters)));

    return List.from((responseBody["data"] as List).map((e) => TimingsModel.fromJson(e)));
  }
}
