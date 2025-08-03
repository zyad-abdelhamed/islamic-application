import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/surah_item.dart';
import 'package:test_app/features/app/presentation/view/pages/tafsier_page.dart';

class SurahListPage extends StatefulWidget {
  const SurahListPage({super.key});

  @override
  State<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  Map<String, String> selectedEdition = AppStrings.tafsirEditions.first;

  bool get isDark {
    return ThemeCubit.controller(context).state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [AppColors.darkModePrimaryColor, AppColors.purple]
                : [AppColors.lightModePrimaryColor, AppColors.secondryColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // DropDown for Tafsir Edition
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                child: DropdownButtonFormField<Map<String, String>>(
                  value: selectedEdition,
                  decoration: InputDecoration(
                    prefix: GetAdaptiveBackButtonWidget(),
                    filled: true,
                    fillColor: isDark ? AppColors.grey2 : AppColors.grey1,
                    labelText: 'اختر التفسير',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: AppStrings.tafsirEditions.map((edition) {
                    return DropdownMenuItem<Map<String, String>>(
                      value: edition,
                      child: Text(edition['name'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedEdition = value;
                      });
                    }
                  },
                ),
              ),

              // Surah List
              Expanded(
                child: ListView.builder(
                  itemCount: AppStrings.surahs.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemBuilder: (context, index) {
                    final surah = AppStrings.surahs[index];
                    final textColor = isDark
                        ? AppColors.darkModeTextColor
                        : AppColors.lightModeTextColor;

                    return GestureDetector(
                      onTap: () {
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
            ? AppColors.black.withValues(alpha: 0.6)
            : AppColors.white.withValues(alpha: 0.9),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
