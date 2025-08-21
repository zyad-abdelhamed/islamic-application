import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

abstract class RecordsLocalDataSource {
  Future<void> deleteRecord({required RecordsParameters parameters});
  Future<void> addRecord({required RecordsParameters parameters});
  Future<void> deleteAllRecords();
  Future<List<FeaturedRecordEntity>> getRecords();
}

class RecordsLocalDataSourceImpl extends RecordsLocalDataSource {
  final Box<FeaturedRecordEntity> _box =
      Hive.box<FeaturedRecordEntity>(DataBaseConstants.featuerdRecordsHiveKey);

  @override
  Future<void> addRecord({required RecordsParameters parameters}) async {
    await _box.add(parameters.recordEntity!);
  }

  @override
  Future<void> deleteAllRecords() async {
    await _box.clear();
  }

  @override
  Future<void> deleteRecord({required RecordsParameters parameters}) async {
    await _box.deleteAt(parameters.index!);
  }

  @override
  Future<List<FeaturedRecordEntity>> getRecords() async {
    return _box.values.toList();
  }
}
