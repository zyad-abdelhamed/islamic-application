import 'package:hive/hive.dart';

class AyahEntity {
  final int number;
  final String text;

  AyahEntity({
    required this.number,
    required this.text,
  });
}

class TypeAdapterForAyahEntity extends TypeAdapter<AyahEntity> {
  @override
  void write(BinaryWriter writer, AyahEntity obj) {
    writer.writeInt(obj.number);
    writer.writeString(obj.text);
  }

  @override
  AyahEntity read(BinaryReader reader) {
    return AyahEntity(
      number: reader.readInt(),
      text: reader.readString(),
    );
  }

  @override
  int get typeId => 81;
}
