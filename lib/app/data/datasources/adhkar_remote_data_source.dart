
import 'package:test_app/app/data/models/adhkar_model.dart';
import 'package:test_app/core/constants/apiconstants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';

abstract class AdhkarRemoteDataSource {
  Future<List<AdhkarModel>> getAdhkar({required String nameOfAdhkar});
}

class AdhkarRemoteDataSourceImpl extends AdhkarRemoteDataSource {
  ApiService apiService;

  AdhkarRemoteDataSourceImpl({required this.apiService});
  @override
  Future<List<AdhkarModel>> getAdhkar({required String nameOfAdhkar}) async {
    Map<String, dynamic> responseBody = await apiService.get(
        apiServiceInputModel:
            ApiServiceInputModel(url: Apiconstants.adhkarUrl));
    return List<AdhkarModel>.from(
        responseBody[nameOfAdhkar].map((e) => AdhkarModel.fromJson(json: e)));
  }
}
