import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/view/components/surah_item.dart';
import 'package:test_app/features/app/presentation/view/pages/tafsier_page.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/core/services/dependency_injection.dart';

Widget buildSurahList(
    ValueNotifier<Map<String, dynamic>> selectedEditionNotifier) {
  return ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    itemCount: AppStrings.surahs.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (context, index) {
      bool isDark = ThemeCubit.controller(context).state;

      Color textColor =
          isDark ? AppColors.darkModeTextColor : AppColors.lightModePrimaryColor;

      final surah = AppStrings.surahs[index];

      return GestureDetector(
        onTap: () {
          final selectedEdition = selectedEditionNotifier.value;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => TafsirCubit(sl()),
                child: TafsirPage(
                  params: TafsirRequestParams(
                    surahNumber: index + 1,
                    edition: selectedEdition['identifier']!,
                    surahName: surah['name']!,
                  ),
                ),
              ),
            ),
          );
        },
        child: SurahItem(
          surah: surah,
          textColor: textColor,
          cardColor: isDark
              ? AppColors.black.withAlpha(150)
              : AppColors.white.withAlpha(230),
        ),
      );
    },
  );
}
