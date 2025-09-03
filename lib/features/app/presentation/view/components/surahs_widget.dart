import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/surah_item.dart';
import 'package:test_app/features/app/presentation/view/components/surahs_search_text_filed.dart';

class SurahsWidget extends StatelessWidget {
  const SurahsWidget({super.key, required this.quranPageController});
  final QuranPageController quranPageController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const SurahsSearchTextFiled(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<GetSurahsInfoCubit, GetSurahsInfoState>(
              builder: (context, state) {
                return getWidgetDependingOnReuestState(
                  requestStateEnum: state.state,
                  widgetIncaseSuccess: ListView.separated(
                    itemCount: state.surahsInfo.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final SurahEntity surahInfo = state.surahsInfo[index];
                      final int pageNum = (surahInfo.pageNumber) - 1;

                      final bool isSelected = quranPageController
                          .indexsNotifier.value
                          .contains(surahInfo.pageNumber);

                      return GestureDetector(
                        onTap: () {
                          QuranCubit.getQuranController(context)
                              .goToPageByNumber(
                            quranPageController,
                            pageNum,
                            quranPageController
                                .updateIndexNotifier(context, pageNum)
                                .toList(),
                          );
                          Navigator.pop(context);
                        },
                        child: SurahItem(
                            surah: surahInfo,
                            textColor: Colors.white,
                            cardColor: isSelected
                                ? AppColors.secondryColor
                                : Colors.transparent,
                            borderColor: Colors.transparent,
                            borderRadius: 0.0),
                      );
                    },
                  ),
                  erorrMessage: state.errorMessage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
