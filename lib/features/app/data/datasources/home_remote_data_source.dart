import 'package:test_app/features/app/data/models/hadith_model.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/core/constants/api_constants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<Hadith>> getAhadiths();
}

class HomeRemoteDataSource implements BaseHomeRemoteDataSource {
  const HomeRemoteDataSource({required this.apiService});

  final ApiService apiService;

  @override
  Future<List<Hadith>> getAhadiths() async {
    Map<String, dynamic> jsonBody = await apiService.get(
        apiServiceInputModel:
            ApiServiceInputModel(url: Apiconstants.ahadithUrl));

    List<Map<String, dynamic>> jsonAhadith = jsonBody[''];
    return List<Hadith>.from(jsonAhadith
        .map((jsonHadith) => HadithModel.fromJson(jsonHadith))
        .toList());
  }
}
