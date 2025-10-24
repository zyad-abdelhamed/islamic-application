import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/surah_audio_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_menu.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/play_surah_audio_widget.dart';
import 'package:test_app/features/app/presentation/view/components/quran_text_view.dart';

class GetSurahWithTafsirSuccessStateView extends StatelessWidget {
  const GetSurahWithTafsirSuccessStateView({
    super.key,
    required this.state,
    required this.controller,
    required this.surahAudioController,
  });

  final GetSurahWithTafsirSuccess state;
  final TafsirPageController controller;
  final SurahAudioController surahAudioController;

  @override
  Widget build(BuildContext context) {
    final SurahWithTafsirEntity data = state.surahWithTafsir;
    final List<AyahEntity> items = data.ayahsList;

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: QuranTextView(
                  ayat: items,
                  onLongPress: (ayahNum, globalPosition) {
                    if (controller.selectedAyah.value != ayahNum) {
                      controller.selectedAyah.value = ayahNum;
                      AyahMenu(controller)
                          .show(context, ayahNum, items, data, globalPosition);
                      return;
                    }
                    controller.hideHighlight();
                  },
                  selectedAyah: controller.selectedAyah,
                  fontSizeNotifier: controller.fontSizeNotifier,
                ),
              ),
              if (state.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AppLoadingWidget(),
                ),
              if (state.hasMore)
                Align(
                  alignment: Alignment.center,
                  child: Card(
                    child: TextButton.icon(
                      onPressed: () => controller.tafsirCubit.loadMore(),
                      icon: const Icon(Icons.menu_book,
                          size: 20, color: AppColors.secondryColor),
                      label: const Text(
                        "عرض المزيد",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondryColor,
                        ),
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
          ),
        ),
        PlaySurahAudioWidget(
          controller: surahAudioController,
          tafsirPageController: controller,
        )
      ],
    );
  }
}
