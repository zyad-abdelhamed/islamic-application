import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';

enum QuranSearchStatus { initial, loading, success, failure }

class QuranSearchState extends Equatable {
  final QuranSearchStatus status;
  final SearchAyahWithTafsirEntity? result;
  final String? errorMessage;
  final List<String> recentSearches;

  const QuranSearchState({
    this.status = QuranSearchStatus.initial,
    this.result,
    this.errorMessage,
    this.recentSearches = const [],
  });

  QuranSearchState copyWith({
    QuranSearchStatus? status,
    SearchAyahWithTafsirEntity? result,
    String? errorMessage,
    List<String>? recentSearches,
  }) {
    return QuranSearchState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage, recentSearches];
}
