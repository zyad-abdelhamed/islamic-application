import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_app/app/data/models/adhkar_model.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

abstract class HomeLocalDataSource {
  Future<List<AdhkarEntity>> getAdhkar(AdhkarParameters adhkarParameters);
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {

  @override
  Future<List<AdhkarEntity>> getAdhkar(AdhkarParameters adhkarParameters) async {
    Map<String, dynamic> jsonAdhkar = await _getAdhkarFromJson();
    // List<Map<String, dynamic>> adhkar = jsonAdhkar[adhkarParameters.nameOfAdhkar];
    // print('=========$adhkar');
    return List<AdhkarEntity>.from((jsonAdhkar[adhkarParameters.nameOfAdhkar]as List).map((e) => AdhkarModel.fromJson(json: e)));
  }

  Future<Map<String, dynamic>> _getAdhkarFromJson() async {
    
      String jsonString = await rootBundle.loadString(DataBaseConstants.adhkarjsonFileRoute);
      return json.decode(jsonString);
    } 
}
