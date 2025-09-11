import 'package:hive/hive.dart';

class TafsirAyahEntity {
  const TafsirAyahEntity({required this.text});

  final String text;
}

class TafsirAyahEntityAdapter extends TypeAdapter<TafsirAyahEntity> {
  @override
  TafsirAyahEntity read(BinaryReader reader) =>
      TafsirAyahEntity(text: reader.readString());

  @override
  void write(BinaryWriter writer, TafsirAyahEntity obj) =>
      writer.writeString(obj.text);

  @override
  int get typeId => 82;
}
