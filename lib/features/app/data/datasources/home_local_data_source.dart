import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/features/app/data/models/adhkar_model.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/data/models/hadith_model.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';

abstract class HomeLocalDataSource {
  Future<List<AdhkarEntity>> getAdhkar(AdhkarParameters adhkarParameters);
  Future<Hadith> getAhadiths();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
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
    final Map<String, dynamic> jsondecoded =
        await getJson(DataBaseConstants.hadithjsonFileRoute);

    return HadithModel(
        content: jsondecoded["hadiths"]
            [getRandomNumber(ConstantsValues.numberOfHadiths)]);
  }
}
