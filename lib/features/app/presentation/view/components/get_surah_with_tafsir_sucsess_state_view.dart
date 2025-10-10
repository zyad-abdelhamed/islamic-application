import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/share_button.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/copy_button.dart';
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
            ayat: items,
            onLongPress: (ayahNum, globalPosition) {
              if (controller.selectedAyah.value != ayahNum) {
                controller.selectedAyah.value = ayahNum;
                showAyahMenu(context, ayahNum, items, data, globalPosition);
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
            child: GetAdaptiveLoadingWidget(),
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
    );
  }

  void showAyahMenu(
    BuildContext context,
    int ayahNum,
    List<AyahEntity> items,
    SurahWithTafsirEntity data,
    Offset globalPosition,
  ) {
    final String ayahText = items[ayahNum - 1].text;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromLTRB(
      globalPosition.dx,
      globalPosition.dy,
      overlay.size.width - globalPosition.dx,
      overlay.size.height - globalPosition.dy,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          onTap: () => showTafsirBottomSheet(context, ayahNum, items, data),
          child: const Text("تفسير الآية"),
        ),
        PopupMenuItem(
          onTap: () {},
          child: const Text("تشغيل الصوت"),
        ),
        PopupMenuItem(
          child: CopyButton(textToCopy: ayahText),
        ),
        PopupMenuItem(
          child: ShareButton(text: ayahText),
        ),
      ],
    );
  }

  void showTafsirBottomSheet(
    BuildContext context,
    int ayahNum,
    List<AyahEntity> items,
    SurahWithTafsirEntity data,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
  }
}
