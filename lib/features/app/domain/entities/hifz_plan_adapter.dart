import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_prograss_entity.dart';

class HifzPlanAdapter extends TypeAdapter<HifzPlanEntity> {
  @override
  final int typeId = 201;

  @override
  HifzPlanEntity read(BinaryReader reader) {
    final planName = reader.readString();
    final createdAt = reader.read() as DateTime;
    final lastProgress = reader.readString();
    final surahsProgress = reader.readMap().cast<String, SurahProgressEntity>();

    return HifzPlanEntity(
      planName: planName,
      createdAt: createdAt,
      lastProgress: lastProgress,
      surahsProgress: surahsProgress,
    );
  }

  @override
  void write(BinaryWriter writer, HifzPlanEntity obj) {
    writer.writeString(obj.planName);
    writer.write(obj.createdAt);
    writer.writeString(obj.lastProgress);
    writer.writeMap(obj.surahsProgress);
  }
}
