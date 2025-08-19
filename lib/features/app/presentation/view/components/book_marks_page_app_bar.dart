import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/presentation/controller/controllers/book_marks_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_state.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';

class BookMarksPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookMarksPageAppBar({super.key, required this.controller});

  final BookmarksController controller;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _deleteSelected(BuildContext context) async {
    final List<int> indexes = controller.selectedIndexes.value;
    if (indexes.isEmpty) return;
    await BookmarksCubit.controller(context).deleteBookmarksList(indexes);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isSelectionMode,
      builder: (_, selectionMode, __) {
        return BlocListener<BookmarksCubit, BookmarksState>(
          listener: (context, state) {
            if (state is DeleteBookmarkLoading) {
              controller.loadingNotifier.value = true;
            } else if (state is DeleteBookmarksuccess) {
              controller.loadingNotifier.value = false;
              controller.exitSelectionMode();
              Navigator.pop(context);
              AppSnackBar(
                message: "تم الحذف بنجاح",
                type: AppSnackBarType.success,
              ).show(context);
            } else if (state is BookmarksError) {
              controller.loadingNotifier.value = false;
              AppSnackBar(
                message: state.message,
                type: AppSnackBarType.error,
              ).show(context);
            }
          },
          child: AppBar(
            title: ValueListenableBuilder<List<int>>(
              valueListenable: controller.selectedIndexes,
              builder: (_, selected, __) {
                if (selectionMode) {
                  return FittedBox(fit: BoxFit.scaleDown,
                    child: Text('تحديد العناصر (${selected.length})'));
                }
                return const Text('العلامات');
              },
            ),
            actions: selectionMode
                ? [
                    IconButton(
                      icon: const Icon(CupertinoIcons.delete),
                      onPressed: () {
                        showDeleteAlertDialog(
                          context,
                          deleteFunction: () async {
                            await _deleteSelected(context);
                          },
                        );
                      },
                    ),
                    TextButton(
                      child: Text(
                        AppStrings.translate("deleteAll"),
                        style: TextStyles.regular16_120(context,
                            color: AppColors.errorColor),
                      ),
                      onPressed: () {
                        showDeleteAlertDialog(
                          context,
                          deleteFunction: () async {
                            await BookmarksCubit.controller(context)
                                .clearBookmarks();
                          },
                        );
                      },
                    ),
                  ]
                : [],
          ),
        );
      },
    );
  }
}
