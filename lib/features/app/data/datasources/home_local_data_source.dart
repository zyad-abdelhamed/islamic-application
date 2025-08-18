import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/core/services/cache_service%20copy.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/data/models/adhkar_model.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/data/models/duaa_model.dart';
import 'package:test_app/features/app/data/models/hadith_model.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';

abstract class HomeLocalDataSource {
  Future<List<AdhkarEntity>> getAdhkar(AdhkarParameters adhkarParameters);
  Future<Hadith> getAhadiths();
  Future<void> cacheTodayHadithDate(String date);
  String? getLastHadithDate();
  Future<List<DuaaModel>> getDuaas();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  static const _lastHadithDateKey = 'lastHadithDateKey';

  @override
  Future<List<AdhkarEntity>> getAdhkar(
      AdhkarParameters adhkarParameters) async {
    Map<String, dynamic> jsonAdhkar =
        await getJson(DataBaseConstants.adhkarjsonFileRoute);
    return List<AdhkarEntity>.from(
        (jsonAdhkar[adhkarParameters.nameOfAdhkar] as List)
            .map((e) => AdhkarModel.fromJson(json: e)));
  }

  @override
  Future<Hadith> getAhadiths() async {
    return HadithModel(
        content: (await getJson(DataBaseConstants.hadithjsonFileRoute))[
            getRandomNumber(ConstantsValues.numberOfHadiths)]);
  }

  @override
  Future<void> cacheTodayHadithDate(String date) async {
    await sl<BaseCacheService>()
        .insertStringToCache(key: _lastHadithDateKey, value: date);
  }

  @override
  String? getLastHadithDate() {
    return sl<BaseCacheService>().getStringFromCache(key: _lastHadithDateKey);
  }

  @override
  Future<List<DuaaModel>> getDuaas() async {
    final List decodedJson = await getJson(DataBaseConstants.duaajsonFileRoute);
    return List<DuaaModel>.from(decodedJson.map((e) => DuaaModel.fromJson(e)))
        .toList();
  }
}
