import 'package:test_app/features/app/domain/entities/allah_name.dart';

class AllahNameModel extends AllahNameEntity {
  const AllahNameModel({
    required super.name,
    required super.transliteration,
    required super.meaning,
    required super.description,
    super.isFavorite,
    required super.audioUrl,
  });

  factory AllahNameModel.fromJson(Map<String, dynamic> json) {
    final String fullAudioUrl = "https://islamicapi.com${json['audioUrl']}";

    return AllahNameModel(
      name: json['name'],
      transliteration: json['transliteration'],
      meaning: json['meaning'],
      description: json['description'],
      audioUrl: fullAudioUrl,
    );
  }
}
