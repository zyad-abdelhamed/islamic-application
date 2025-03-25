
import 'package:test_app/app/data/models/timings_model.dart';
import 'package:test_app/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/core/constants/apiconstants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';

abstract class PrayersRemoteDataSource {
  Future<TimingsModel> getPrayersTimes({required TimingsParameters parameters});
}

class PrayersRemoteDataSourceImpl implements PrayersRemoteDataSource {
  ApiService apiService;
  PrayersRemoteDataSourceImpl(this.apiService);
  @override
  Future<TimingsModel> getPrayersTimes(
      {required TimingsParameters parameters}) async {
    var responseBody = await apiService.get(
        apiServiceInputModel: ApiServiceInputModel(
            url: Apiconstants.getTimingsUrl(
                parameters.latitude, parameters.longitude)));
    return TimingsModel.fromJson(responseBody['data']['timings']);
  }
}
