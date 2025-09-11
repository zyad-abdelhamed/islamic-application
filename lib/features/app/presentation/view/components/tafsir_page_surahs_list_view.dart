import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_edition_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/slidable_item.dart';
import 'package:test_app/features/app/presentation/view/pages/tafsier_page.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class TafsirPageSurahsListView extends StatelessWidget {
  const TafsirPageSurahsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSurahsInfoCubit, GetSurahsInfoState>(
      builder: (context, state) {
        return getWidgetDependingOnReuestState(
            requestStateEnum: state.state,
            widgetIncaseSuccess: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.surahsInfo.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (BuildContext context, int index) {
                bool isDark = Theme.of(context).brightness == Brightness.dark;

                Color textColor = isDark
                    ? AppColors.darkModeTextColor
                    : AppColors.lightModePrimaryColor;

                final SurahEntity surah = state.surahsInfo[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<GetSurahWithTafsirCubit>(
                          create: (_) => sl<GetSurahWithTafsirCubit>(),
                          child: TafsirPage(
                            params: TafsirRequestParams(
                              surahNumber: _getSurahNumber(context, surah),
                              edition: selectedEdition.identifier,
                              surahName: surah.name,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: SlidableItem(
                    surah: surah,
                    textColor: textColor,
                    surahNumber: _getSurahNumber(context, surah),
                  ),
                );
              },
            ),
            erorrMessage: state.errorMessage);
      },
    );
  }

  int _getSurahNumber(BuildContext context, SurahEntity surah) {
    return context.read<GetSurahsInfoCubit>().surahsInfo.indexOf(surah) +
        1; // هنا لازم نجيب الرقم من الليست الاصليه علشان ميحصلش تضارب مع ليست السيرش
  }
}
