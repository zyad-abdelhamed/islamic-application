import 'package:hive/hive.dart';

class AyahEntity {
  final int number;
  final String text;
  final bool sajda;

  AyahEntity({
    required this.number,
    required this.text,
    required this.sajda,
  });
}

class TypeAdapterForAyahEntity extends TypeAdapter<AyahEntity> {
  @override
  void write(BinaryWriter writer, AyahEntity obj) {
    writer.writeInt(obj.number);
    writer.writeString(obj.text);
    writer.writeBool(obj.sajda);
  }

  @override
  AyahEntity read(BinaryReader reader) {
    return AyahEntity(
        number: reader.readInt(),
        text: reader.readString(),
        sajda: reader.readBool());
  }

  @override
  int get typeId => 81;
}
