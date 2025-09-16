import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/quran_text_view.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_ayah_bottom_sheet.dart';

class GetSurahWithTafsirSuccessStateView extends StatelessWidget {
  const GetSurahWithTafsirSuccessStateView({
    super.key,
    required this.state,
    required this.controller,
  });

  final GetSurahWithTafsirSuccess state;
  final TafsirPageController controller;

  @override
  Widget build(BuildContext context) {
    final SurahWithTafsirEntity data = state.surahWithTafsir;
    final List<AyahEntity> items = data.ayahsList;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: QuranTextView(
            // surahName: data.surahName,
            ayat: items,
            onLongPress: (int ayahNum) {
              if (controller.selectedAyah.value != ayahNum) {
                controller.selectedAyah.value = ayahNum;
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return TafsirBottomSheet(
                      ayahText: items[ayahNum - 1].text,
                      allTafsir: (tafsirEditions) => Map.fromEntries(
                        tafsirEditions.map((editionName) {
                          return MapEntry(
                            editionName,
                            data.allTafsir[editionName]![ayahNum - 1],
                          );
                        }),
                      ),
                      index: ayahNum - 1,
                    );
                  },
                );

                return;
              }

              controller.hideHighlight();
            },
            selectedAyah: controller.selectedAyah,
            fontSizeNotifier: controller.fontSizeNotifier,
          ),
        ),
        //  آخر عنصر: حسب الحالة نعرض زر عرض المزيد أو لودينج أو رسالة
        if (state.isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: GetAdaptiveLoadingWidget(),
          ),
        if (state.hasMore)
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => controller.tafsirCubit.loadMore(),
                child: const Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book,
                        size: 20, color: AppColors.secondryColor),
                    Text(
                      "عرض المزيد",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        if (state.loadMoreError != null)
          ErrorWidgetIslamic(
            message: state.loadMoreError!,
            buttonWidget: Text(AppStrings.translate("tryAgain")),
            onPressed: () => controller.tafsirCubit.retry(),
          )
      ],
    );
  }
}
