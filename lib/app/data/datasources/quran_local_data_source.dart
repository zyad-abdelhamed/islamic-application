import 'package:test_app/app/data/models/quran_model.dart';

abstract class QuranLocalDataSource {
  Future<List<QuranModel>> getInfoQuran({required String part});
}
class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  @override
  Future<List<QuranModel>> getInfoQuran({required String part}) {
    // TODO: implement getInfoQuran
    throw UnimplementedError();
  }
}