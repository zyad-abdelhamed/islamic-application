import 'package:test_app/features/app/domain/entities/surah_entity.dart';

abstract class QuranRequestParams {
  final int surahNumber;
  final SurahEntity surah;
  final int offset;
  final int limit;

  const QuranRequestParams({
    required this.surahNumber,
    required this.surah,
    this.offset = 0,
    this.limit = 10,
  });
}

class TafsirRequestParams extends QuranRequestParams {
  final String? edition;

  const TafsirRequestParams({
    this.edition,
    required super.surahNumber,
    required super.surah,
    super.offset,
    super.limit,
  });

  TafsirRequestParams copyWith({
    String? edition,
    int? surahNumber,
    SurahEntity? surah,
    int? offset,
    int? limit,
  }) {
    return TafsirRequestParams(
      edition: edition ?? this.edition,
      surahNumber: surahNumber ?? this.surahNumber,
      surah: surah ?? this.surah,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}

class SurahRequestParams extends QuranRequestParams {
  const SurahRequestParams({
    required super.surah,
    required super.surahNumber,
    super.offset,
    super.limit,
  });

  SurahRequestParams copyWith({
    SurahEntity? surah,
    int? surahNumber,
    int? offset,
    int? limit,
  }) {
    return SurahRequestParams(
      surah: surah ?? this.surah,
      surahNumber: surahNumber ?? this.surahNumber,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
