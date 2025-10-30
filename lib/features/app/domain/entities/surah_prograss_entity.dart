class SurahProgressEntity {
  final String surahName; // اسم السورة
  final Set<int> memorizedAyahs; // الآيات اللى سمعها المستخدم منها

  const SurahProgressEntity({
    required this.surahName,
    required this.memorizedAyahs,
  });
}
