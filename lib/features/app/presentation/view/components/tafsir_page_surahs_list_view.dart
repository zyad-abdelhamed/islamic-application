import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/slidable_item.dart';
import 'package:test_app/features/app/presentation/view/pages/tafsier_page.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class TafsirPageSurahsListView extends StatelessWidget {
  final bool showOnlyDownloaded;
  final bool showOnlyNotDownloaded;

  const TafsirPageSurahsListView({
    super.key,
    this.showOnlyDownloaded = false,
    this.showOnlyNotDownloaded = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSurahsInfoCubit, GetSurahsInfoState>(
      builder: (context, state) {
        int tabNumber;
        // فلترة حسب التبويب
        List<SurahEntity> filtered = state.surahsInfo;
        tabNumber = 1;
        if (showOnlyDownloaded) {
          filtered = state.surahsInfo.where((s) => s.isDownloaded).toList();
          tabNumber = 2;
        } else if (showOnlyNotDownloaded) {
          filtered = state.surahsInfo.where((s) => !s.isDownloaded).toList();
          tabNumber = 3;
        }

        return getWidgetDependingOnReuestState(
          requestStateEnum: state.state,
          widgetIncaseSuccess: ListView.builder(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 30.0),
            itemCount: filtered.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final SurahEntity surah = filtered[index];

              return GestureDetector(
                onTap: () => _goToAlquranAndTafsirPage(context, surah),
                child: SlidableItem(
                  key: ObjectKey(surah),
                  surah: surah,
                  textColor: AppColors.primaryColor,
                  surahNumber: _getSurahNumber(context, surah),
                  showSaveIcon: tabNumber == 1,
                ),
              );
            },
          ),
          erorrMessage: state.errorMessage,
        );
      },
    );
  }

  void _goToAlquranAndTafsirPage(BuildContext context, SurahEntity surah) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider<GetSurahWithTafsirCubit>(
          create: (_) => sl<GetSurahWithTafsirCubit>(),
          child: TafsirPage(
            surahEntity: surah,
            tafsirRequestParams: TafsirRequestParams(
              surahNumber: _getSurahNumber(context, surah),
              surah: surah,
            ),
            surahParams: SurahRequestParams(
              surahNumber: _getSurahNumber(context, surah),
              surah: surah,
            ),
          ),
        ),
      ),
    );
  }

  int _getSurahNumber(BuildContext context, SurahEntity surah) {
    return context.read<GetSurahsInfoCubit>().surahsInfo.indexOf(surah) + 1;
    // هنا لازم نجيب الرقم من الليست الاصليه علشان ميحصلش تضارب مع ليست السيرش
  }
}
