import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/app_functionalty_button.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_state.dart';
import 'package:test_app/core/widgets/custom_alert_dialog.dart';
import 'package:test_app/features/app/presentation/view/pages/book_marks_page.dart';

const String _buttonName = 'حفظ العلامة';

class QuranPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuranPageAppBar({super.key, required this.quranPageController});

  final QuranPageController quranPageController;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return AppBar(
        leading: const GetAdaptiveBackButtonWidget(),
        title: FittedBox(
          child: Text(
            AppStrings.appBarTitles(withTwoLines: false)[0],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => sl<BookmarksCubit>(),
                  child: CustomAlertDialog(
                    title: "حفظ علامة",
                    alertDialogContent: (context) {
                      return Form(
                        key: BookmarksCubit.controller(context).formKey,
                        child: Column(
                          spacing: 15,
                          children: [
                            TextFormField(
                              controller: BookmarksCubit.controller(context)
                                  .textEditingController,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                hintText: 'اكتب اسم العلامة',
                              ),
                              validator:
                                  BookmarksCubit.controller(context).validator,
                            ),
                            // زر الحفظ
                            BlocListener<BookmarksCubit, BookmarksState>(
                              listener: (context, state) {
                                if (state is AddBookmarksuccess) {
                                  Navigator.pop(context);
                                  AppSnackBar(
                                          message: "تم حفظ العلامة بنجاح",
                                          type: AppSnackBarType.success)
                                      .show(context);
                                } else if (state is BookmarksError) {
                                  AppSnackBar(
                                          message: state.message,
                                          type: AppSnackBarType.error)
                                      .show(context);
                                }
                              },
                              child: AppFunctionaltyButton<BookmarksCubit,
                                  BookmarksState>(
                                buttonName: _buttonName,
                                onPressed: () =>
                                    BookmarksCubit.controller(context)
                                        .addBookmark(quranPageController),
                                isLoading: (state) =>
                                    state is AddBookmarkLoading,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    iconWidget: (context) => const Icon(
                      Icons.bookmark_border_rounded,
                      color: AppColors.secondryColor,
                    ),
                  ),
                ),
              );
            },
            child: Icon(
              Icons.bookmark_border_rounded,
              size: 35,
              color: color,
            ),
          ),
          TextButton(
              // go to bookmarks
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookmarksPage(
                          quranPageController: quranPageController))),
              child: Text(
                "العلامات",
                style:
                    TextStyles.semiBold16_120(context).copyWith(color: color),
              )),
          Builder(
            builder: (context) {
              return TextButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: Text(
                  AppStrings.translate("theIndex"),
                  style:
                      TextStyles.semiBold16_120(context).copyWith(color: color),
                ),
              );
            },
          ),
        ]);
  }
}
