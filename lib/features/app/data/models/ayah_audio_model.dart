import 'package:test_app/features/app/domain/entities/ayah_audio_entity.dart';

class AyahAudioModel extends AyahAudioEntity {
  const AyahAudioModel({
    required super.text,
    required super.audioUrl,
    required super.audioSecondary,
    required super.numberInSurah,
  });

  factory AyahAudioModel.fromJson(Map<String, dynamic> json) {
    return AyahAudioModel(
      text: json["text"] ?? "",
      audioUrl: json["audio"] ?? "",
      audioSecondary: (json["audioSecondary"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      numberInSurah: json["numberInSurah"] ?? 0,
    );
  }
}
