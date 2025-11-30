import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_range_picker_dialog.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plan_surah_item.dart';

class QuranMemorizationPlanPage extends StatelessWidget {
  const QuranMemorizationPlanPage({super.key, required this.hifzPlanEntity});

  final HifzPlanEntity hifzPlanEntity;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        leading:
            const GetAdaptiveBackButtonWidget(backBehavior: BackBehavior.pop),
        title: Text(hifzPlanEntity.planName),
      ),
      body: BlocBuilder<GetSurahsInfoCubit, GetSurahsInfoState>(
        builder: (context, state) {
          return getWidgetDependingOnReuestState(
            requestStateEnum: state.state,
            widgetIncaseSuccess: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.surahsInfo.length,
              itemBuilder: (BuildContext context, int i) {
                final SurahEntity surah = state.surahsInfo[i];

                return GestureDetector(
                  onTap: () {
                    final memorizedAyahs = hifzPlanEntity
                            .surahsProgress[surah.name]?.memorizedAyahs ??
                        [];

                    showDialog(
                      context: context,
                      builder: (_) => AyahRangePickerDialog(
                        surah: surah,
                        memorizedAyahs: memorizedAyahs,
                        index: i,
                      ),
                    );
                  },
                  child: QuranMemorizationPlanSurahItem(
                    surah: surah,
                    memorizedAyat: hifzPlanEntity
                            .surahsProgress[surah.name]?.memorizedAyahs ??
                        [],
                  ),
                );
              },
            ),
            erorrMessage: state.errorMessage,
          );
        },
      ),
    );
  }
}
