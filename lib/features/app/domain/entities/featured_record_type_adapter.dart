import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';

class FeaturedRecordEntityAdapter extends TypeAdapter<FeaturedRecordEntity> {
  @override
  final int typeId = 8;

  @override
  FeaturedRecordEntity read(BinaryReader reader) {
    final id = reader.readInt();
    final value = reader.readInt();
    return FeaturedRecordEntity(id: id, value: value);
  }

  @override
  void write(BinaryWriter writer, FeaturedRecordEntity obj) {
    writer.writeInt(obj.id);
    writer.writeInt(obj.value);
  }
}
