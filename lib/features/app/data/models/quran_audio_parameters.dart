enum AudioQuality {
  q192,
  q128,
  q64,
  q48,
  q40,
  q32;

  int get value {
    switch (this) {
      case AudioQuality.q192:
        return 192;
      case AudioQuality.q128:
        return 128;
      case AudioQuality.q64:
        return 64;
      case AudioQuality.q48:
        return 48;
      case AudioQuality.q40:
        return 40;
      case AudioQuality.q32:
        return 32;
    }
  }
}

abstract class BaseAudioRequestParams {
  final String reciterId;
  final AudioQuality quality;
  final int? surahNumber;

  const BaseAudioRequestParams({
    required this.reciterId,
    this.surahNumber,
    this.quality = AudioQuality.q128,
  });

  int get bitrate => quality.value;
}

class AyahAudioRequestParams extends BaseAudioRequestParams {
  final int ayahGlobalNumber; // رقم الآية في المصحف بالكامل (1–6236)

  const AyahAudioRequestParams({
    required super.reciterId,
    super.quality,
    required this.ayahGlobalNumber,
  });
}

class SurahAudioRequestParams extends BaseAudioRequestParams {
  final String surahName;
  final String reciterName;

  const SurahAudioRequestParams({
    required super.reciterId,
    required this.reciterName,
    super.quality,
    required super.surahNumber,
    required this.surahName,
  });
}
