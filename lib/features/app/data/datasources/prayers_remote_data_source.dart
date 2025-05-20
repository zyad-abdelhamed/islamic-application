import 'package:test_app/features/app/data/models/timings_model.dart';
import 'package:test_app/core/constants/api_constants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';

abstract class PrayersRemoteDataSource {
  Future<TimingsModel> getPrayersTimes();
}

class PrayersRemoteDataSourceImpl implements PrayersRemoteDataSource {
  final ApiService apiService;
  PrayersRemoteDataSourceImpl(this.apiService);
  @override
  Future<TimingsModel> getPrayersTimes() async {
    var responseBody = await apiService.get(
        apiServiceInputModel:
            ApiServiceInputModel(url: await Apiconstants.getTimingsUrl));
    return TimingsModel.fromJson(responseBody['data']['timings']);
  }
}
