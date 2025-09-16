import 'package:test_app/core/constants/api_constants.dart';
import 'package:test_app/core/models/api_service_input_model.dart';
import 'package:test_app/core/services/api_services.dart';
import 'package:test_app/features/app/data/models/ayah_model.dart';
import 'package:test_app/features/app/data/models/ayah_search_result_model.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/data/models/tafsir_ayah_model.dart';

abstract class BaseQuranRemoteDataSource {
  Future<List<TafsirAyahModel>> getTafsirAyahs(TafsirRequestParams params);
  Future<List<AyahModel>> getAyahs(SurahRequestParams params);
  Future<AyahSearchResultModel> searchInQuran(String keyword);
  Future<TafsirAyahModel> getAyahTafsir(int ayahNumber, String edition);
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
    if (ayahsList.isEmpty) {
      return List.generate(params.surah.numberOfAyat,
          (e) => TafsirAyahModel(text: "لا يوجد تفسير متاح لهذه الآية"));
    }
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

  @override
  Future<AyahSearchResultModel> searchInQuran(String keyword) async {
    final Map<String, dynamic> jsonBody = await apiService.get(
      apiServiceInputModel: ApiServiceInputModel(
        url: Apiconstants.getSearchUrl(keyword),
      ),
    );
    print("getAyahTafsir raw jsonBody: $jsonBody");

    final dynamic rawData = jsonBody['data'];

    return AyahSearchResultModel.fromJson(rawData);
  }

  @override
  Future<TafsirAyahModel> getAyahTafsir(int ayahNumber, String edition) async {
    final Map<String, dynamic> jsonBody = await apiService.get(
      apiServiceInputModel: ApiServiceInputModel(
        url: Apiconstants.getAyahTafsirUrl(
          ayahNumber: ayahNumber,
          edition: edition,
        ),
      ),
    );

    final dynamic rawData = jsonBody['data'];

    if (jsonBody['code'] != 200 ||
        rawData == null ||
        rawData is! Map<String, dynamic>) {
      print(
          "⚠️ Tafsir not found or bad format for ayah=$ayahNumber, edition=$edition");
      return TafsirAyahModel(text: "لا يوجد تفسير متاح لهذه الآية");
    }

    try {
      return TafsirAyahModel.fromJson(rawData);
    } catch (e) {
      print("❌ Parsing error tafsir ayah=$ayahNumber, edition=$edition");
      return TafsirAyahModel(text: "لا يوجد تفسير متاح لهذه الآية");
    }
  }
}
