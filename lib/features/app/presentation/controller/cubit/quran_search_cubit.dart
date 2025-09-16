import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

import 'quran_search_state.dart';

class QuranSearchCubit extends HydratedCubit<QuranSearchState> {
  final BaseQuranRepo quranRepo;

  QuranSearchCubit(this.quranRepo) : super(const QuranSearchState());

  Future<void> search(String query) async {
    emit(state.copyWith(status: QuranSearchStatus.loading));

    final result = await quranRepo.search(query);

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(state.copyWith(
            status: QuranSearchStatus.failure,
            errorMessage: failure.message,
          ));
        }
      },
      (searchResult) {
        // حفظ البحث الأخير
        final updatedRecent = [
          query.trim(),
          ...state.recentSearches.where((q) => q != query.trim()),
        ].take(10).toList();

        if (!isClosed) {
          emit(state.copyWith(
            status: QuranSearchStatus.success,
            result: searchResult,
            recentSearches: updatedRecent,
          ));
        }
      },
    );
  }

  void removeRecent(String query) {
    final updated = state.recentSearches.where((q) => q != query).toList();
    emit(state.copyWith(recentSearches: updated));
  }

  void clearRecents() {
    emit(state.copyWith(recentSearches: []));
  }

  @override
  QuranSearchState? fromJson(Map<String, dynamic> json) {
    final recents =
        (json['recent'] as List?)?.map((e) => e.toString()).toList() ?? [];
    return QuranSearchState(recentSearches: recents);
  }

  @override
  Map<String, dynamic>? toJson(QuranSearchState state) {
    return {'recent': state.recentSearches};
  }
}
