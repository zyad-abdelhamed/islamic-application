import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/settings_container_decoration.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/book_marks_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';

class BookmarkItem extends StatelessWidget {
  final BookMarkEntity bookmark;
  final ValueChanged<bool> onSelectionChanged;
  final BookmarksController bookmarksController;
  final int index;
  final QuranPageController quranPageController;

  const BookmarkItem({
    super.key,
    required this.bookmark,
    required this.onSelectionChanged,
    required this.bookmarksController,
    required this.index,
    required this.quranPageController,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<bool>(
      valueListenable: bookmarksController.isSelectionMode,
      builder: (context, isSelectionMode, _) {
        return ValueListenableBuilder<List<int>>(
          valueListenable: bookmarksController.selectedIndexes,
          builder: (context, selectedIndexes, __) {
            final bool isSelected = selectedIndexes.contains(index);

            return GestureDetector(
              onTap: () {
                if (isSelectionMode) {
                  onSelectionChanged(!isSelected);
                } else {
                  // open book mark
                  Navigator.pop(context);
                  QuranCubit.getQuranController(context).goToPageByNumber(
                      quranPageController,
                      bookmark.pageNumber,
                      bookmark.indexs);
                }
              },
              onLongPress: () {
                if (!isSelectionMode) {
                  onSelectionChanged(true);
                }
              },
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (AppColors.lightModeInActiveColor)
                          : (isDark ? Colors.grey[850] : Colors.white),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.lightModePrimaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: isSelected
                          ? [] // بدون شادو عند التحديد
                          : getAppBoxShadow(context),
                    ),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      bookmark.title,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyles.bold20(context).copyWith(
                          color: isSelected
                              ? AppColors.lightModePrimaryColor
                              : (isDark ? Colors.white : Colors.black87)),
                    ),
                  ),

                  // علامة الصح
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    top: isSelected ? 16 : -16,
                    right: 16,
                    child: AnimatedOpacity(
                      opacity: isSelected ? 1 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.successColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
