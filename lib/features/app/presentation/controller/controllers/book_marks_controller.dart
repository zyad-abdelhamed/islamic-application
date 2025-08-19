import 'package:flutter/material.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';

class BookmarksController {
  late final ValueNotifier<bool> isSelectionMode;
  late final ValueNotifier<List<int>> selectedIndexes;
  late final ValueNotifier<bool> loadingNotifier;

  void initstate(BuildContext context) {
    isSelectionMode = ValueNotifier<bool>(false);
    selectedIndexes = ValueNotifier<List<int>>([]);
    loadingNotifier = ValueNotifier<bool>(false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppSnackBar(message: "اضغط مطولا للحذف", type: AppSnackBarType.info)
          .show(context);
    });
  }

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
