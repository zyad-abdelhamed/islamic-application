import 'package:hive/hive.dart';
import 'daily_adhkar_entity.dart';

class DailyAdhkarEntityAdapter extends TypeAdapter<DailyAdhkarEntity> {
  @override
  final int typeId = 9;

  @override
  DailyAdhkarEntity read(BinaryReader reader) {
    // text
    final hasText = reader.readBool();
    final text = hasText ? reader.readString() : null;

    // image
    final hasImage = reader.readBool();
    final image = hasImage ? reader.readByteList() : null;

    // flags
    final isShowed = reader.readBool();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());

    return DailyAdhkarEntity(
      text: text,
      image: image,
      isShowed: isShowed,
      createdAt: createdAt,
    );
  }

  @override
  void write(BinaryWriter writer, DailyAdhkarEntity obj) {
    // text
    if (obj.text != null) {
      writer.writeBool(true);
      writer.writeString(obj.text!);
    } else {
      writer.writeBool(false);
    }

    // image
    if (obj.image != null) {
      writer.writeBool(true);
      writer.writeByteList(obj.image!);
    } else {
      writer.writeBool(false);
    }

    // flags
    writer.writeBool(obj.isShowed);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}
