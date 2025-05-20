import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';

class SurahsWidget extends StatelessWidget {
  const SurahsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: AppStrings.surahPages.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          int pageNum = AppStrings.surahPages.values.elementAt(index) - 1;
          return BlocBuilder<QuranCubit, QuranState>(
            buildWhen: (previous, current) => current.cIndex == index || previous.cIndex == index,
            builder: (context, state) {
              print("rebuild AnimatedContainer $index");
              return AnimatedContainer(
                color: index == state.cIndex
                    ? AppColors.secondryColor
                    : Colors.transparent,
                duration: AppDurations.mediumDuration,
                child: TextButton(
                  onPressed: () {
                    QuranCubit.getQuranController(context)
                        .goToPageByNumber(pageNum, index);
                  },
                  child: Text(
                    'سورة ${AppStrings.surahPages.keys.elementAt(index)}',
                    style: TextStyles.bold20(context).copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
