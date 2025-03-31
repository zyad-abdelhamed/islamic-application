import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:test_app/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/services/data_base_service.dart';

abstract class RecordsLocalDataSource {
  Future<Unit> deleteRecord({required RecordsParameters parameters});
  Future<Unit> addRecord({required RecordsParameters parameters});
  Future<Unit> deleteAllRecords({required RecordsParameters parameters});
  Future<List<int>> getRecords();
}
class RecordsLocalDataSourceImpl extends RecordsLocalDataSource{
  final BaseDataBaseService<int> baseDataBaseService;
  RecordsLocalDataSourceImpl({required this.baseDataBaseService});
  @override
  Future<Unit> addRecord({required RecordsParameters parameters}) async{
   await baseDataBaseService.add(parameters.item!, DataBaseConstants.featuerdRecordsHiveKey);
    return unit;
  }

  @override
  Future<Unit> deleteAllRecords({required RecordsParameters parameters}) async{
  await baseDataBaseService.deleteAll(DataBaseConstants.featuerdRecordsHiveKey);
    return unit;
  }

  @override
  Future<Unit> deleteRecord({required RecordsParameters parameters})async {
  await  baseDataBaseService.delete(parameters.id, DataBaseConstants.featuerdRecordsHiveKey);
    return unit;
  }

  @override
  Future<List<int>> getRecords()async {
   return await baseDataBaseService.get(DataBaseConstants.featuerdRecordsHiveKey); 
  }
}
