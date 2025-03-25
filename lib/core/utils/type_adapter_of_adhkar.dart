import 'package:hive/hive.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';

class TypeAdapterOfAdhkar extends TypeAdapter<AdhkarEntity> {
  @override
  AdhkarEntity read(BinaryReader reader) {
    return AdhkarEntity(
        count: reader.readString(),
        description: reader.readString(),
        content: reader.readString());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, AdhkarEntity obj) {
    writer.writeString(obj.count);
    writer.writeString(obj.description);
    writer.writeString(obj.content);
  }
}
