import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_state.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';
import 'package:test_app/features/app/presentation/view/pages/book_marks_page.dart';

const String _buttonName = 'حفظ العلامة';
List<Widget> quranPageAppBarActions(
    BuildContext context, QuranPageController quranPageController) {
  final color =
      ThemeCubit.controller(context).state ? Colors.white : Colors.black;

  return [
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
                        validator: BookmarksCubit.controller(context).validator,
                      ),
                      // زر الحفظ
                      BlocConsumer<BookmarksCubit, BookmarksState>(
                        listener: (context, state) {
                          if (state is AddBookmarksuccess) {
                            Navigator.pop(context);
                            AppSnackBar(
                                message: "تم حفظ العلامة بنجاح",
                                type: AppSnackBarType.success).show(context);
                          } else if (state is BookmarksError) {
                            AppSnackBar(
                                message: state.message,
                                type: AppSnackBarType.error).show(context);
                          }
                        },
                        builder: (context, state) {
                          return MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () =>
                                  BookmarksCubit.controller(context)
                                      .addBookmark(quranPageController),
                              disabledColor: Colors.grey,
                              color: Theme.of(context).primaryColor,
                              child:
                                  BlocBuilder<BookmarksCubit, BookmarksState>(
                                builder: (context, state) {
                                  return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: state is AddBookmarkLoading
                                          ? Row(
                                              spacing: 5,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("يتم $_buttonName ..."),
                                                GetAdaptiveLoadingWidget(),
                                              ],
                                            )
                                          : Text(
                                              _buttonName,
                                              style: TextStyle(
                                                  color: AppColors.white),
                                            ));
                                },
                              ));
                        },
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
                builder: (context) =>
                    BookmarksPage(quranPageController: quranPageController))),
        child: Text(
          "العلامات",
          style: TextStyles.semiBold16_120(context).copyWith(color: color),
        )),
    Builder(
      builder: (context) {
        return TextButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          child: Text(
            AppStrings.translate("theIndex"),
            style: TextStyles.semiBold16_120(context).copyWith(color: color),
          ),
        );
      },
    ),
  ];
}
