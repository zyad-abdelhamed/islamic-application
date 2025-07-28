import 'dart:convert';

import 'package:flutter/services.dart';
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
    Map<String, dynamic> jsonAdhkar = await _getAdhkarFromJson();
    return List<AdhkarEntity>.from(
        (jsonAdhkar[adhkarParameters.nameOfAdhkar] as List)
            .map((e) => AdhkarModel.fromJson(json: e)));
  }

  Future<Map<String, dynamic>> _getAdhkarFromJson() async {
    final String jsonString =
        await rootBundle.loadString(DataBaseConstants.adhkarjsonFileRoute);
    return json.decode(jsonString);
  }

  @override
  Future<Hadith> getAhadiths() async {
    final String jsonString =
        await rootBundle.loadString(DataBaseConstants.hadithjsonFileRoute);
  final  jsondecoded = json.decode(jsonString);

    return HadithModel.fromJson(jsondecoded[getRandomNumber(7)]);

  }
}
