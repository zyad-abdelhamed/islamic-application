import 'package:hive/hive.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';

class LocationTypeAdapter extends TypeAdapter<LocationEntity> {
  @override
  LocationEntity read(BinaryReader reader) {
    return LocationEntity(
        latitude: reader.readDouble(),
        longitude: reader.readDouble(),
        name: reader.readString());
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, LocationEntity obj) {
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
    writer.writeString(obj.name);
  }
}
