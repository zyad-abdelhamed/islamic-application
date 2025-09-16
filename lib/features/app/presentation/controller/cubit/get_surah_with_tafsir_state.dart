import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

abstract class GetSurahWithTafsirState extends Equatable {
  const GetSurahWithTafsirState();

  @override
  List<Object?> get props => [];
}

class GetSurahWithTafsirInitial extends GetSurahWithTafsirState {}

class GetSurahWithTafsirLoading extends GetSurahWithTafsirState {}

class GetSurahWithTafsirSuccess extends GetSurahWithTafsirState {
  final SurahWithTafsirEntity surahWithTafsir;
  final bool isLoadingMore;
  final bool hasMore;
  final String? loadMoreError;

  const GetSurahWithTafsirSuccess(
    this.surahWithTafsir, {
    this.isLoadingMore = false,
    this.hasMore = true,
    this.loadMoreError,
  });

  GetSurahWithTafsirSuccess copyWith({
    SurahWithTafsirEntity? surahWithTafsir,
    bool? isLoadingMore,
    bool? hasMore,
    String? loadMoreError,
  }) {
    return GetSurahWithTafsirSuccess(
      surahWithTafsir ?? this.surahWithTafsir,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      loadMoreError: loadMoreError,
    );
  }

  @override
  List<Object?> get props => [
        surahWithTafsir,
        isLoadingMore,
        hasMore,
        loadMoreError,
      ];
}

class GetSurahWithTafsirFailure extends GetSurahWithTafsirState {
  final String message;

  const GetSurahWithTafsirFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GetSurahWithTafsirSearchState extends GetSurahWithTafsirState {
  final List<AyahEntity> ayahs;
  final Map<String, List<TafsirAyahEntity>> tafsirAyahs;

  const GetSurahWithTafsirSearchState({
    required this.ayahs,
    required this.tafsirAyahs,
  });

  @override
  List<Object?> get props => [
        ayahs,
        tafsirAyahs,
      ];
}

class GetSurahWithTafsirSearchNotFoundDataState
    extends GetSurahWithTafsirState {
  final String message = "لا يوجد نتائج للبحث";
}
