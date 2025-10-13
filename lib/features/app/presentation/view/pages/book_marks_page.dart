import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/core/widgets/empty_list_text_widget.dart';
import 'package:test_app/features/app/presentation/controller/controllers/book_marks_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_state.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/book_mark_item.dart';
import 'package:test_app/features/app/presentation/view/components/book_marks_page_app_bar.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key, required this.quranPageController});
  final QuranPageController quranPageController;

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  late final BookmarksController controller;

  @override
  void initState() {
    super.initState();
    controller = BookmarksController();
    controller.initstate(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookmarksCubit>(
      create: (_) => sl<BookmarksCubit>(),
      child: ValueListenableBuilder<bool>(
        valueListenable: controller.loadingNotifier,
        builder: (_, __, ___) => ModalProgressHUD(
          inAsyncCall: controller.loadingNotifier.value,
          progressIndicator: const AppLoadingWidget(),
          opacity: .5,
          child: Scaffold(
            appBar: BookMarksPageAppBar(controller: controller),
            body: BlocConsumer<BookmarksCubit, BookmarksState>(
              listener: (ctx, state) {
                if (state is BookmarksLoaded) {
                  if (state.bookmarks.isNotEmpty) {
                    AppSnackBar(
                            message: "اضغط مطولا للحذف",
                            type: AppSnackBarType.info)
                        .show(ctx);
                  }
                }
              },
              builder: (ctx, state) {
                if (state is BookmarksLoading) {
                  return const AppLoadingWidget();
                } else if (state is BookmarksLoaded) {
                  final bookmarks = state.bookmarks;
                  if (bookmarks.isEmpty) {
                    return EmptyListTextWidget(
                        text: AppStrings.translate("noBookmarks"));
                  }

                  return BlocProvider<QuranCubit>(
                    create: (context) => sl<QuranCubit>(),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: bookmarks.length,
                      itemBuilder: (context, index) {
                        return BookmarkItem(
                          quranPageController: widget.quranPageController,
                          bookmarksController: controller,
                          index: index,
                          bookmark: bookmarks[index],
                          onSelectionChanged: (isSelected) {
                            if (!controller.isSelectionMode.value) {
                              controller.enterSelectionMode();
                            }
                            controller.toggleSelection(index, isSelected);
                          },
                        );
                      },
                    ),
                  );
                } else if (state is BookmarksError) {
                  return EmptyListTextWidget(text: state.message);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
