import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/features/duaa/data/models/duaa_model.dart';

abstract class DuaaLocalDataSource {
  Future<List<DuaaModel>> getDuaaWithPegnation({required int page});
}

class DuaaLocalDataSourceImpl implements DuaaLocalDataSource {
  @override
  Future<List<DuaaModel>> getDuaaWithPegnation({required int page}) async {
    final jsonFile =
        await rootBundle.loadString(DataBaseConstants.duaajsonFileRoute);
    final decodedJson = jsonDecode(jsonFile);
    List<DuaaModel> returnedList =
        List<DuaaModel>.from(decodedJson.map((e) => DuaaModel.fromJson(e)))
            .toList();
    int startIndex = (page) * 10;
    if (startIndex >= returnedList.length) {
      return <DuaaModel>[];
    }
    int endIndex = (startIndex + 10).clamp(0, returnedList.length);

    return returnedList.sublist(startIndex, endIndex);
  }
}
