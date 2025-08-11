import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_state.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

const String _buttonName = 'حفظ العلامة';
List<Widget> quranPageAppBarActions(BuildContext context) {
  final color =
      ThemeCubit.controller(context).state ? Colors.white : Colors.black;

  return [
    GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => BlocProvider(
            create: (context) => BookmarkCubit(),
            child: CustomAlertDialog(
              title: "حفظ علامة",
              alertDialogContent: (context) {
                final BookmarkCubit bookmarkCubit = context.read<BookmarkCubit>();
                return Form(
                  key: bookmarkCubit.formKey,
                  child: Column(
                    spacing: 15,
                    children: [
                      TextFormField(
                        controller: bookmarkCubit.controller,
                        maxLength: 40,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          hintText: 'اكتب اسم العلامة',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: bookmarkCubit.validateBookmark,
                      ),
                      // زر الحفظ
                      MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => bookmarkCubit.saveBookmark(),
                disabledColor: Colors.grey,
                color: Theme.of(context).primaryColor,
                child: BlocBuilder<BookmarkCubit, BookmarkState>(
                  builder: (context, state) {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: state is BookmarkSavedLoading
                            ? Row(
                                spacing: 5,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("يتم $_buttonName ..."),
                                  GetAdaptiveLoadingWidget(),
                                ],
                              )
                            : Text(
                                _buttonName,
                                style: TextStyle(color: AppColors.white),
                              ));
                  },
                )),
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
      onPressed: () {},
      child: Text(
        "العلامات",
        style: TextStyles.semiBold16_120(context).copyWith(color: color),
      ),
    ),
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
