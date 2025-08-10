import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';

class TypeAdapterForBookMark extends TypeAdapter<BookMarkEntity> {
  @override
  BookMarkEntity read(BinaryReader reader) {
    return BookMarkEntity(
        title: reader.readString(), pageNumber: reader.readInt());
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, BookMarkEntity obj) {
    writer.writeString(obj.title);
    writer.writeInt(obj.pageNumber);
  }
}
