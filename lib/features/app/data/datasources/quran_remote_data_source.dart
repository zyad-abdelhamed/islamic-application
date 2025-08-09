import 'package:test_app/core/constants/api_constants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';
import 'package:test_app/features/app/data/models/tafsir_ayah_model.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';

abstract class BaseQuranRemoteDataSource {
  Future<List<TafsirAyahModel>> getSurahWithTafsir(TafsirRequestParams params);
}

class QuranRemoteDataSource extends BaseQuranRemoteDataSource {
  final ApiService apiService;

  QuranRemoteDataSource({required this.apiService});
  @override
  Future<List<TafsirAyahModel>> getSurahWithTafsir(
      TafsirRequestParams params) async {
    final jsonBody = await apiService.get(
      apiServiceInputModel: ApiServiceInputModel(
        url: Apiconstants.getTafsirUrl(params),
      ),
    );

    final List<dynamic> ayahList = jsonBody["data"]["ayahs"];

    return ayahList.map((e) => TafsirAyahModel.fromJson(e)).toList();
  }
}
