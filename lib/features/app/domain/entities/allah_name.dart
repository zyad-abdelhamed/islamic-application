class AllahNameEntity {
  final String name;
  final String transliteration;
  final String meaning;
  final String description;
  final bool isFavorite;
  final String audioUrl;

  const AllahNameEntity({
    required this.name,
    required this.transliteration,
    required this.meaning,
    required this.description,
    this.isFavorite = false,
    required this.audioUrl,
  });

  AllahNameEntity copyWith({
    String? name,
    String? transliteration,
    String? meaning,
    String? description,
    bool? isFavorite,
    String? audioUrl,
  }) {
    return AllahNameEntity(
      name: name ?? this.name,
      transliteration: transliteration ?? this.transliteration,
      meaning: meaning ?? this.meaning,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }
}
