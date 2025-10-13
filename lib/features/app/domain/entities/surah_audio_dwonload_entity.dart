import 'package:hive/hive.dart';

class SurahAudioDownloadEntity {
  final SurahAudioDownloadStatus status;
  final List<int> failedAyahs;

  SurahAudioDownloadEntity({
    required this.status,
    required this.failedAyahs,
  });
}

enum SurahAudioDownloadStatus {
  complete,
  partial,
}

class SurahAudioDownloadEntityAdapter
    extends TypeAdapter<SurahAudioDownloadEntity> {
  @override
  final int typeId = 51;

  @override
  SurahAudioDownloadEntity read(BinaryReader reader) {
    final statusIndex = reader.readInt();
    final status = SurahAudioDownloadStatus.values[statusIndex];

    final failedAyahs = reader.readList().cast<int>();

    return SurahAudioDownloadEntity(
      status: status,
      failedAyahs: failedAyahs,
    );
  }

  @override
  void write(BinaryWriter writer, SurahAudioDownloadEntity obj) {
    writer.writeInt(obj.status.index);
    writer.writeList(obj.failedAyahs);
  }
}

class SurahAudioDownloadStatusAdapter
    extends TypeAdapter<SurahAudioDownloadStatus> {
  @override
  final int typeId = 61;

  @override
  SurahAudioDownloadStatus read(BinaryReader reader) {
    return SurahAudioDownloadStatus.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, SurahAudioDownloadStatus obj) {
    writer.writeInt(obj.index);
  }
}
