import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tafsir_state.dart';

class TafsirEditCubit extends Cubit<TafsirEditState> {
  TafsirEditCubit()
      : super(const TafsirEditState(
          selected: [],
          available: [
            'تفسير البغوي',
            'تفسير السعدي',
            'تفسير ابن كثير',
            'معاني الكلمات',
            'التفسير الميسر',
            'تفسير الجلالين',
          ],
        ));

  static const _selectedKey = 'selected_tafsir';

  Future<void> loadTafsir() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_selectedKey);

    if (saved != null && saved.isNotEmpty) {
      final available = List<String>.from(state.available)
        ..removeWhere((e) => saved.contains(e));

      emit(TafsirEditState(selected: saved, available: available));
    } else {
      final all = List<String>.from(state.available);
      emit(TafsirEditState(selected: all, available: []));
      await _save(all);
    }
  }

  Future<void> addTafsir(String tafsir) async {
    final newSelected = List<String>.from(state.selected)..add(tafsir);
    final newAvailable = List<String>.from(state.available)..remove(tafsir);

    emit(state.copyWith(selected: newSelected, available: newAvailable));
    await _save(newSelected);
  }

  Future<void> removeTafsir(String tafsir) async {
    if (state.selected.length <= 1) return;

    final newAvailable = List<String>.from(state.available)..add(tafsir);
    final newSelected = List<String>.from(state.selected)..remove(tafsir);

    emit(state.copyWith(selected: newSelected, available: newAvailable));
    await _save(newSelected);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final newSelected = List<String>.from(state.selected);
    if (newIndex > oldIndex) newIndex -= 1;
    final item = newSelected.removeAt(oldIndex);
    newSelected.insert(newIndex, item);

    emit(state.copyWith(selected: newSelected));
    await _save(newSelected);
  }

  Future<void> _save(List<String> selected) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_selectedKey, selected);
  }
}
