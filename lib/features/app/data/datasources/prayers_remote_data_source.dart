import 'package:test_app/features/app/data/models/next_prayer.dart';
import 'package:test_app/features/app/data/models/timings_model.dart';
import 'package:test_app/core/constants/apiconstants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';

abstract class PrayersRemoteDataSource {
  Future<TimingsModel> getPrayersTimes();
  Future<NextPrayerModel> getRemainingTimeToNextPrayer();
}

class PrayersRemoteDataSourceImpl implements PrayersRemoteDataSource {
  final ApiService apiService;
  PrayersRemoteDataSourceImpl(this.apiService);
  @override
  Future<TimingsModel> getPrayersTimes() async {
    var responseBody = await apiService.get(
        apiServiceInputModel:
            ApiServiceInputModel(url: Apiconstants.getTimingsUrl));
    return TimingsModel.fromJson(responseBody['data']['timings']);
  }

  @override
  Future<NextPrayerModel> getRemainingTimeToNextPrayer() async {
    Map<String, dynamic> responseBody = await apiService.get(
        apiServiceInputModel:
            ApiServiceInputModel(url: Apiconstants.getnextPrayersUrl));
    return NextPrayerModel.fromJson(responseBody['data']['timings']);
  }
}
