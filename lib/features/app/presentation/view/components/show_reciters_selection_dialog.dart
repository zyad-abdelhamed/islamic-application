import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'reciter_check_tile.dart'; // استدعاء الويدجت السابقة

Future<void> showRecitersSelectionDialog({
  required BuildContext context,
  required List<ReciterEntity> reciters,
  required ValueNotifier<List<ReciterEntity>> selectedReciters,
  required Function(List<ReciterEntity>) onConfirm,
}) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: AppColors.lightModeScaffoldBackGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          "اختر الشيوخ",
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: ValueListenableBuilder<List<ReciterEntity>>(
          valueListenable: selectedReciters,
          builder: (context, selected, _) {
            return SizedBox(
              width: double.maxFinite,
              height: context.height * 0.5,
              child: ListView.builder(
                itemCount: reciters.length,
                itemBuilder: (context, index) {
                  final reciter = reciters[index];
                  final isSelected = selected.contains(reciter);

                  return ReciterCheckTile(
                    reciter: reciter,
                    isSelected: isSelected,
                    onChanged: (value) {
                      final updated = List<ReciterEntity>.from(selected);
                      if (value == true) {
                        updated.add(reciter);
                      } else {
                        updated.remove(reciter);
                      }
                      selectedReciters.value = updated;
                    },
                  );
                },
              ),
            );
          },
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              onConfirm(selectedReciters.value);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
