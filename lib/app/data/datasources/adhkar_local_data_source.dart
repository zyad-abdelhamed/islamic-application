import 'package:hive/hive.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/core/services/data_base_service.dart';

abstract class AdhkarLocalDataSource {
  Future<List<AdhkarEntity>> getCachedAdhkar();
  Future<void> cacheAdhkar(List<AdhkarEntity> adhkar);
}

class AdhkarLocalDataSourceImpl extends AdhkarLocalDataSource {
  final BaseDataBaseService<int> baseDataBaseService;
  late final Box<List<AdhkarEntity>> box;
 
  AdhkarLocalDataSourceImpl(this.baseDataBaseService);
  
  Future<void> _initBox() async {
    box = await Hive.openBox<List<AdhkarEntity>>('adhkar');
  }

  @override
  Future<void> cacheAdhkar(List<AdhkarEntity> adhkar) async {
    
    await _initBox();
    await box.put('adhkar', adhkar);
    await box.addAll(adhkar as Iterable<List<AdhkarEntity>>);
  }

  @override
  Future<List<AdhkarEntity>> getCachedAdhkar() async {
    await _initBox();
    return box.get('adhkar', defaultValue: []) ?? [];
  }
}
