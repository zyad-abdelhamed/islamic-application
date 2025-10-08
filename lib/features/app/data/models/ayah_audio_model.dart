import '../../domain/entities/ayah_audio_entity.dart';

class AyahAudioModel extends AyahAudioEntity {
  const AyahAudioModel({
    super.text,
    required super.audioUrl,
  });

  factory AyahAudioModel.fromJson(Map<String, dynamic> json) {
    return AyahAudioModel(
      text: json["text"] ?? "",
      audioUrl: json["audio"] ?? "",
    );
  }
}