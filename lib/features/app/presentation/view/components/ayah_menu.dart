import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/helper_function/is_dark.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/file_storage_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/share_button.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/ayah_audio_card_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_audio_card.dart';
import 'package:test_app/features/app/presentation/view/components/copy_button.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_ayah_bottom_sheet.dart';

class AyahMenu {
  final TafsirPageController controller;
  AyahMenu(this.controller);
  void show(
    BuildContext context,
    int ayahNum,
    List<AyahEntity> items,
    SurahWithTafsirEntity data,
    Offset globalPosition,
  ) {
    final String ayahText = items[ayahNum - 1].text;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Size screenSize = overlay.size;
    final double dialogWidth = 320;
    final double dialogHeight = 80;

    // حساب الموضع المناسب للعرض داخل الشاشة
    final double left =
        globalPosition.dx.clamp(0.0, screenSize.width - dialogWidth);
    final double top =
        globalPosition.dy.clamp(0.0, screenSize.height - dialogHeight);

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: left,
              top: top,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: dialogWidth,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: isDark(context) ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(
                          ConstantsValues.fullCircularRadius),
                      boxShadow: [
                        BoxShadow(
                          color: isDark(context)
                              ? Colors.black.withAlpha((0.3 * 255).toInt())
                              : Colors.black.withAlpha((0.15 * 255).toInt()),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: const Offset(0, 6),
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        tooltip: 'تفسير الآية',
                        icon: const Icon(Icons.menu_book_outlined,
                            color: AppColors.primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                          _showTafsirBottomSheet(context, ayahNum, items, data);
                        },
                      ),
                      IconButton(
                        tooltip: 'تكرار تشغيل الصوت',
                        icon: const Icon(Icons.repeat,
                            color: AppColors.primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                          _playAyahAudio(context,
                              ayah: items[ayahNum - 1], isRepeat: true);
                        },
                      ),
                      IconButton(
                        tooltip: 'تشغيل الصوت',
                        icon: const Icon(Icons.play_arrow,
                            color: AppColors.primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                          _playAyahAudio(context,
                              ayah: items[ayahNum - 1], isRepeat: false);
                        },
                      ),
                      Tooltip(
                        message: 'نسخ الآية',
                        child: CopyButton(
                            textToCopy: ayahText,
                            color: AppColors.primaryColor),
                      ),
                      Tooltip(
                        message: 'مشاركة الآية',
                        child: ShareButton(
                            text: ayahText, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTafsirBottomSheet(
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

  void _playAyahAudio(BuildContext context,
      {required AyahEntity ayah, required bool isRepeat}) async {
    final ReciterEntity? currentReciter =
        controller.currentReciterNotifier.value;
    if (currentReciter == null) return;
    final folderName = "${currentReciter.name}_${controller.surahEntity.name}";

    final File file = await sl<IFileStorageService>().getFile(
      folderName: folderName,
      fileName: '${ayah.number}',
      extension: 'mp3',
    );

    final AudioSource source = AudioSource.uri(Uri.file(file.path));

    final AyahAudioCardController ayahAudioCardController =
        AyahAudioCardController(audioSource: source, isRepeat: isRepeat);

    final entry = OverlayEntry(
      builder: (_) => AyahAudioCard(
        key: ValueKey<int>(ayah.number),
        controller: ayahAudioCardController,
        reciterName: currentReciter.name,
        reciterImageUrl: currentReciter.image,
      ),
    );

    ayahAudioCardController.setEntry(entry);
    if (context.mounted) {
      Overlay.of(context).insert(entry);
    }
  }
}
