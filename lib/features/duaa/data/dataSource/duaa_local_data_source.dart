import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/features/duaa/data/models/duaa_model.dart';

abstract class DuaaLocalDataSource {
  Future<List<DuaaModel>> getDuaaWithPegnation();
}

class DuaaLocalDataSourceImpl implements DuaaLocalDataSource {
  @override
  Future<List<DuaaModel>> getDuaaWithPegnation() async {
    final jsonFile =
        await rootBundle.loadString(DataBaseConstants.duaajsonFileRoute);
    final decodedJson = jsonDecode(jsonFile);
    return List<DuaaModel>.from(decodedJson.map((e) => DuaaModel.fromJson(e)));
  }
}
