import 'package:test_app/features/app/domain/entities/surah_audio_dwonload_entity.dart';

class ReciterEntity {
  final String identifier;
  final String language;
  final String name;
  final String image;
  final SurahAudioDownloadEntity? surahAudioDownloadInfo;

  const ReciterEntity({
    required this.identifier,
    required this.language,
    required this.name,
    required this.image,
    this.surahAudioDownloadInfo,
  });
}
