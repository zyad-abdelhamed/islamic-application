import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';

abstract class BaseDailyAdhkarLocalDataSource {
  Future<void> saveDailyAdhkar(DailyAdhkarEntity entity);
  Future<List<DailyAdhkarEntity>> getAllDailyAdhkar();
  Future<void> deleteDailyAdhkar(int index);
  Future<void> markAsShown(int index);
}

class DailyAdhkarLocalDataSourceImpl extends BaseDailyAdhkarLocalDataSource {
  static const String boxName = 'daily_adhkar_box';
  final Box<DailyAdhkarEntity> box = Hive.box<DailyAdhkarEntity>(boxName);

  @override
  Future<void> saveDailyAdhkar(DailyAdhkarEntity entity) async {
    await box.add(entity);
  }

  @override
  Future<void> deleteDailyAdhkar(int index) async {
    await box.deleteAt(index);
  }

  @override
  Future<List<DailyAdhkarEntity>> getAllDailyAdhkar() async {
    final now = DateTime.now();
    final updatedList = <DailyAdhkarEntity>[];

    for (int i = 0; i < box.length; i++) {
      final e = box.getAt(i)!;

      final isValidToday = now.year == e.createdAt.year &&
          now.month == e.createdAt.month &&
          now.day == e.createdAt.day;

      final updatedEntity = DailyAdhkarEntity(
        text: e.text,
        image: e.image,
        isShowed: isValidToday ? e.isShowed : false,
        createdAt: isValidToday ? e.createdAt : now, // تحديث التاريخ لو قديم
      );

      // تحديث في DB
      await box.putAt(i, updatedEntity);
      updatedList.add(updatedEntity);
    }

    return updatedList;
  }

  @override
  Future<void> markAsShown(int index) async {
    final e = box.getAt(index);
    if (e != null) {
      final updatedEntity = DailyAdhkarEntity(
        text: e.text,
        image: e.image,
        isShowed: true,
        createdAt: e.createdAt,
      );
      await box.putAt(index, updatedEntity);
    }
  }
}
