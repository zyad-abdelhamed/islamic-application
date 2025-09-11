import 'package:test_app/core/constants/api_constants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';
import 'package:test_app/features/app/data/models/ayah_model.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/data/models/tafsir_ayah_model.dart';

abstract class BaseQuranRemoteDataSource {
  Future<List<TafsirAyahModel>> getTafsirAyahs(TafsirRequestParams params);
  Future<List<AyahModel>> getAyahs(SurahRequestParams params);
}

class QuranRemoteDataSource extends BaseQuranRemoteDataSource {
  final ApiService apiService;

  QuranRemoteDataSource({required this.apiService});
  @override
  Future<List<TafsirAyahModel>> getTafsirAyahs(
      TafsirRequestParams params) async {
    final Map<String, dynamic> jsonBody = await apiService.get(
      apiServiceInputModel: ApiServiceInputModel(
        url: Apiconstants.getTafsirUrl(params),
      ),
    );

    final List ayahsList = jsonBody["data"]["ayahs"];

    return ayahsList.map((e) => TafsirAyahModel.fromJson(e)).toList();
  }

  @override
  Future<List<AyahModel>> getAyahs(SurahRequestParams params) async {
    final Map<String, dynamic> jsonBody = await apiService.get(
      apiServiceInputModel: ApiServiceInputModel(
        url: Apiconstants.getSurahUrl(params),
      ),
    );

    final List ayahsList = jsonBody["data"]["ayahs"];

    return ayahsList.map((e) => AyahModel.fromJson(e)).toList();
  }
}
