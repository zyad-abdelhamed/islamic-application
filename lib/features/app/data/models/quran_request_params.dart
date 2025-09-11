abstract class QuranRequestParams {
  final int surahNumber;
  final int offset;
  final int limit;

  const QuranRequestParams({
    required this.surahNumber,
    this.offset = 0,
    this.limit = 5,
  });
}

class TafsirRequestParams extends QuranRequestParams {
  final String? edition;
  final String surahName;

  const TafsirRequestParams({
    this.edition,
    required this.surahName,
    required super.surahNumber,
    super.offset,
    super.limit,
  });

  TafsirRequestParams copyWith({
    int? offset,
    int? limit,
    String? edition,
  }) {
    return TafsirRequestParams(
      edition: edition ?? this.edition,
      surahName: surahName,
      surahNumber: surahNumber,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}

class SurahRequestParams extends QuranRequestParams {
  const SurahRequestParams({
    required super.surahNumber,
    super.offset,
    super.limit,
  });

  SurahRequestParams copyWith({
    int? offset,
    int? limit,
  }) {
    return SurahRequestParams(
      surahNumber: surahNumber,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
