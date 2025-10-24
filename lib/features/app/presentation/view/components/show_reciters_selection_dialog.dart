import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/reciters_cubit.dart';
import 'reciter_check_tile.dart';

Future<void> showRecitersSelectionDialog({
  required BuildContext context,
  required String desc,
  required Function(List<ReciterEntity> selectedReciters) onConfirm,
  bool allowMultipleSelection = true,
}) async {
  final ValueNotifier<List<ReciterEntity>> selectedReciters = ValueNotifier([]);

  await showDialog(
    context: context,
    builder: (_) {
      return BlocProvider<RecitersCubit>(
        create: (context) => sl<RecitersCubit>()..getReciters(),
        child: AlertDialog.adaptive(
          title: Text(desc),
          content: BlocBuilder<RecitersCubit, RecitersState>(
            builder: (context, state) {
              final List<ReciterEntity> reciters;

              if (state is RecitersLoaded) {
                reciters = state.reciters;
              } else {
                reciters = [];
              }

              return ValueListenableBuilder<List<ReciterEntity>>(
                valueListenable: selectedReciters,
                builder: (context, selected, _) {
                  return ListView.separated(
                    itemCount: reciters.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final reciter = reciters[index];
                      final isSelected = selected.contains(reciter);

                      return ReciterCheckTile(
                        reciter: reciter,
                        isSelected: isSelected,
                        onChanged: (value) {
                          final updated = List<ReciterEntity>.from(selected);
                          if (value == true) {
                            if (allowMultipleSelection) {
                              updated.add(reciter);
                            } else {
                              updated
                                ..clear()
                                ..add(reciter);
                            }
                          } else {
                            updated.remove(reciter);
                          }
                          selectedReciters.value = updated;
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                onConfirm(selectedReciters.value);
                selectedReciters.dispose();
                Navigator.pop(context);
              },
              child: const Text("تأكيد"),
            ),
          ],
        ),
      );
    },
  );
}
