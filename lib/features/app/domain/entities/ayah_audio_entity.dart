class AyahAudioEntity {
  final String text;
  final String audioUrl;
  final List<String> audioSecondary;
  final int numberInSurah;

  const AyahAudioEntity({
    required this.text,
    required this.audioUrl,
    required this.audioSecondary,
    required this.numberInSurah,
  });
}
