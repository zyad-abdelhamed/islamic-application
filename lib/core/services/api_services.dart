import 'package:dio/dio.dart';
import 'package:test_app/core/models/api_service_input_model.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);
  Future<Map<String, dynamic>> post(
      {required ApiServiceInputModel apiServiceInputModel}) async {
    Response response = await dio.post(apiServiceInputModel.url,
        queryParameters: apiServiceInputModel.body,
        options: Options(headers: apiServiceInputModel.apiHeaders));
    return response.data;
  }

  Future<Map<String, dynamic>> get(
      {required ApiServiceInputModel apiServiceInputModel}) async {
    Response response = await dio.get(apiServiceInputModel.url,
        options: Options(headers: apiServiceInputModel.apiHeaders));
    return response.data;
  }
}
