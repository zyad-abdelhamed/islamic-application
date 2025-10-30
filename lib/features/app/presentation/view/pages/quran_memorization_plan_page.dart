import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plan_surah_item.dart';

class QuranMemorizationPlanPage extends StatelessWidget {
  const QuranMemorizationPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            const GetAdaptiveBackButtonWidget(backBehavior: BackBehavior.pop),
        title: Text(''),
      ),
      body: BlocBuilder<GetSurahsInfoCubit, GetSurahsInfoState>(
        builder: (context, state) {
          return getWidgetDependingOnReuestState(
            requestStateEnum: state.state,
            widgetIncaseSuccess: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.surahsInfo.length,
              itemBuilder: (BuildContext context, int index) {
                final SurahEntity surah = state.surahsInfo[index];

                return GestureDetector(
                  onTap: () => _onTap(context),
                  child: QuranMemorizationPlanSurahItem(
                    surah: surah,
                    memorizedAyat: [1, 2, 3, 4, 5, 6, 7],
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

  void _onTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold();
    }));
  }
}
