import 'package:test_app/features/app/data/models/surah_model.dart';

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getInfoQuran({required String part});
}
class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  @override
  Future<List<SurahModel>> getInfoQuran({required String part}) {
    // TODO: implement getInfoQuran
    throw UnimplementedError();
  }
}