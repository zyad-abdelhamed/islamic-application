import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/surah_item.dart';
import 'package:test_app/features/app/presentation/view/pages/tafsier_page.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class SurahListWithFuture extends StatelessWidget {
  final ValueNotifier<Map<String, dynamic>> selectedEditionNotifier;

  const SurahListWithFuture({super.key, required this.selectedEditionNotifier});

  Future<List<Map<String, dynamic>>> loadSurahs() async {
    final data = await getJson(RoutesConstants.surahsJsonRouteName);
    return List<Map<String, dynamic>>.from(data["surahs"]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: loadSurahs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GetAdaptiveLoadingWidget();
        } else if (snapshot.hasError) {
          return const Center(child: Text('حدث خطأ أثناء تحميل السور'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('لا توجد سور متاحة'));
        }

        final surahs = snapshot.data!;

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: surahs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            bool isDark = ThemeCubit.controller(context).state;

            Color textColor = isDark
                ? AppColors.darkModeTextColor
                : AppColors.lightModePrimaryColor;

            final surah = surahs[index];

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
      },
    );
  }
}
