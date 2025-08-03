class TafsirRequestParams {
  final int surahNumber;
  final String edition;
  final String surahName;
  final int offset;
  final int limit;

  TafsirRequestParams({
    required this.surahNumber,
    required this.edition,
    required this.surahName,
    this.offset = 0,
    this.limit = 10,
  });

  TafsirRequestParams copyWith({
  int? offset,
  int? limit,
}) {
  return TafsirRequestParams(
    surahNumber: surahNumber,
    edition: edition,
    surahName: surahName,
    offset: offset ?? this.offset,
    limit: limit ?? this.limit,
  );
}
}

