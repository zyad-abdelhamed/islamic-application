import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_audio_dwonload_entity.dart';

class RecitersModel extends ReciterEntity {
  const RecitersModel({
    required super.identifier,
    required super.language,
    required super.name,
    required super.image,
    required super.surahAudioDownloadInfo,
  });

  factory RecitersModel.fromJson(Map<String, dynamic> json,
      {required SurahAudioDownloadEntity? surahAudioDownloadInfo}) {
    return RecitersModel(
      identifier: json['identifier'] ?? '',
      language: json['language'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      surahAudioDownloadInfo: surahAudioDownloadInfo,
    );
  }
}
