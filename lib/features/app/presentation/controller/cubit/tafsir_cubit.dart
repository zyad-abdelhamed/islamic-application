import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'tafsir_state.dart';

class TafsirEditCubit extends HydratedCubit<TafsirEditState> {
  TafsirEditCubit() : super(const TafsirEditState()) {
    loadTafsir();
  }

  Future<void> loadTafsir() async {
    if (state.selected.isEmpty) {
      final all = List<String>.from(state.available);
      emit(TafsirEditState(selected: all, available: []));
    }
  }

  Future<void> addTafsir(String tafsir) async {
    final newSelected = List<String>.from(state.selected)..add(tafsir);
    final newAvailable = List<String>.from(state.available)..remove(tafsir);

    emit(state.copyWith(selected: newSelected, available: newAvailable));
  }

  Future<void> removeTafsir(String tafsir) async {
    if (state.selected.length <= 1) return;

    final newAvailable = List<String>.from(state.available)..add(tafsir);
    final newSelected = List<String>.from(state.selected)..remove(tafsir);

    emit(state.copyWith(selected: newSelected, available: newAvailable));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final newSelected = List<String>.from(state.selected);
    if (newIndex > oldIndex) newIndex -= 1;
    final item = newSelected.removeAt(oldIndex);
    newSelected.insert(newIndex, item);

    emit(state.copyWith(selected: newSelected));
  }

  // Hydrated overrides
  @override
  TafsirEditState? fromJson(Map<String, dynamic> json) {
    try {
      return TafsirEditState(
        selected: List<String>.from(json['selected'] ?? []),
        available: List<String>.from(json['available'] ?? []),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TafsirEditState state) {
    return {
      'selected': state.selected,
      'available': state.available,
    };
  }
}
