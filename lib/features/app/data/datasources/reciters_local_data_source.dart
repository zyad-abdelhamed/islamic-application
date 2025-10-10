import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_app/features/app/data/models/reciters_model.dart';

abstract class RecitersLocalDataSource {
  Future<List<RecitersModel>> getReciters();
}

class RecitersLocalDataSourceImpl extends RecitersLocalDataSource {
  @override
  Future<List<RecitersModel>> getReciters() async {
    final loadedJson =
        await rootBundle.loadString('assets/jsons/reciters.json');
    final data = json.decode(loadedJson);
    return List.from((data as List).map((e) => RecitersModel.fromJson(e)));
  }
}
