import 'package:flutter/material.dart';

class BookmarksController {
  final ValueNotifier<bool> isSelectionMode = ValueNotifier<bool>(false);
  final ValueNotifier<List<int>> selectedIndexes = ValueNotifier<List<int>>([]);
  final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);

  void enterSelectionMode() {
    isSelectionMode.value = true;
  }

  void exitSelectionMode() {
    isSelectionMode.value = false;
    selectedIndexes.value = [];
  }

  /// يبدّل حالة التحديد لعنصر بالـ index
  void toggleSelection(int index, bool isSelected) {
    final current = List<int>.from(selectedIndexes.value);
    if (isSelected) {
      if (!current.contains(index)) current.add(index);
    } else {
      current.remove(index);
    }
    selectedIndexes.value = current;
    // لو مافيش مُحددات نخرج من وضع التحديد
    if (current.isEmpty) {
      exitSelectionMode();
    } else {
      isSelectionMode.value = true;
    }
  }

  void dispose() {
    isSelectionMode.dispose();
    selectedIndexes.dispose();
    loadingNotifier.dispose();
  }
}
