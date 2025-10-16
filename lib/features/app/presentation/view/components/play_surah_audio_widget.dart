import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:test_app/core/helper_function/is_dark.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/surah_audio_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/playing_reciters_bottom_sheet.dart';

class PlaySurahAudioWidget extends StatelessWidget {
  final double imageSize;
  final SurahAudioController controller;
  final TafsirPageController tafsirPageController;

  const PlaySurahAudioWidget({
    super.key,
    this.imageSize = 30,
    required this.controller,
    required this.tafsirPageController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ReciterEntity?>(
      valueListenable: tafsirPageController.currentReciterNotifier,
      builder: (context, reciter, child) {
        final bool isActive = reciter != null;
        final Color actionsColor =
            isActive ? AppColors.primaryColor : Colors.grey;

        return AbsorbPointer(
          absorbing: !isActive,
          child: ListTile(
            minVerticalPadding: 0,
            dense: true,
            visualDensity: VisualDensity(horizontal: -2, vertical: -2),
            tileColor: isDark(context) ? Colors.black : Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            onTap: isActive ? () => _openBottomSheet(context) : null,
            leading: Container(
              width: imageSize,
              height: imageSize,
              decoration: isActive
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(reciter.image),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const BoxDecoration(color: Colors.grey),
            ),
            title: Text(isActive
                ? "${reciter.name}_${tafsirPageController.surahEntity.name}"
                : "غير متاح"),
            subtitle: Text(isActive ? reciter.language : ""),
            trailing: _AudioControls(
              controller: controller,
              imageSize: imageSize,
              actionsColor: actionsColor,
              onHeadphonesPressed: () =>
                  showPlayingRecitersBottomSheet(context),
            ),
          ),
        );
      },
    );
  }

  void _openBottomSheet(BuildContext context) {
    final reciter = tafsirPageController.currentReciterNotifier.value;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Center(
          child: Text(
            "تشغيل سورة ${tafsirPageController.surahEntity.name} بصوت ${reciter?.name ?? "غير متاح"}",
          ),
        ),
      ),
    );
  }

  void showPlayingRecitersBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return PlayingRecitersBottomSheet(controller: tafsirPageController);
      },
    );
  }
}

class _AudioControls extends StatelessWidget {
  final SurahAudioController controller;
  final double imageSize;
  final Color actionsColor;
  final VoidCallback onHeadphonesPressed;

  const _AudioControls({
    required this.controller,
    required this.imageSize,
    required this.actionsColor,
    required this.onHeadphonesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<double>(
          stream: controller.audioPositionStream,
          builder: (_, snapshot) {
            final progress = snapshot.data ?? 0.0;
            return CircularPercentIndicator(
              radius: imageSize / 2,
              lineWidth: 3,
              percent: progress.clamp(0.0, 1.0),
              backgroundColor: AppColors.primaryColor.withAlpha(50),
              progressColor: AppColors.primaryColor,
              center: GestureDetector(
                onTap: () async {
                  if (!controller.isPrepared) {
                    await controller.prepareSurahAudio();
                  } else {
                    final isPlaying = controller.isAudioPlayingNotifier.value;
                    isPlaying
                        ? await controller.pauseSurah()
                        : await controller.resumeSurah();
                  }
                },
                child: Transform.rotate(
                  angle: 90 * pi / 2,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: controller.isAudioPlayingNotifier,
                    builder: (context, isPlaying, _) {
                      return Icon(
                        isPlaying
                            ? CupertinoIcons.pause
                            : CupertinoIcons.play_arrow_solid,
                        color: actionsColor,
                        size: imageSize * 0.6,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            CupertinoIcons.headphones,
            color: actionsColor,
            size: imageSize,
          ),
          onPressed: onHeadphonesPressed,
        ),
      ],
    );
  }
}
