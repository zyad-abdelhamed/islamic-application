import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:test_app/features/app/presentation/controller/controllers/surah_audio_controller.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/ayahs_flow_widget.dart';

class SurahPlayerBottomSheet extends StatelessWidget {
  final SurahAudioController controller;

  const SurahPlayerBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final reciter =
        controller.tafsirPageController.currentReciterNotifier.value;
    if (reciter == null) return const SizedBox.shrink();

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(CupertinoIcons.chevron_down),
                ),
                IconButton(
                  icon: const Icon(Icons.speed),
                  tooltip: 'سرعة التشغيل',
                  onPressed: () => showPlaybackSpeedDialog(
                    context,
                    (newSpeed) => controller.setSpeed(newSpeed),
                  ),
                ),
              ],
            ),

            ClipOval(
              child: Image.asset(
                reciter.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 48,
              child: Marquee(
                text:
                    "${reciter.name} - سورة ${controller.tafsirPageController.surahEntity.name}",
                style: TextStyles.semiBold32auto(context),
                velocity: 40.0,
                blankSpace: 60.0,
                startPadding: 10.0,
                pauseAfterRound: const Duration(milliseconds: 200),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
              ),
            ),

            const SizedBox(height: 12),

            AyahsFlowWidget(
              tafsirPageController: controller.tafsirPageController,
            ),

            const Spacer(),

            // ProgressBar مع Stream واحد من controller.progressStream
            StreamBuilder<ProgressData>(
              stream: controller.progressStream,
              builder: (context, snapshot) {
                final ProgressData data = snapshot.data ??
                    ProgressData(
                        position: Duration.zero,
                        buffered: Duration.zero,
                        total: Duration.zero);

                return ProgressBar(
                  total: data.total,
                  progress: data.position,
                  buffered: data.buffered,
                  progressBarColor: AppColors.primaryColor,
                  bufferedBarColor: AppColors.primaryColor.withAlpha(50),
                  baseBarColor: Theme.of(context).dividerColor,
                  thumbColor: AppColors.primaryColor,
                  onSeek: (newPosition) async =>
                      await controller.audioPlayer.seek(newPosition),
                );
              },
            ),

            const SizedBox(height: 18),

            // أزرار التحكم
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.skip_next),
                  onPressed: () async => controller.seekToNextAyah(),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: controller.isAudioPlayingNotifier,
                  builder: (context, playing, _) {
                    return IconButton(
                      iconSize: 80,
                      color: AppColors.primaryColor,
                      icon: Icon(playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill),
                      onPressed: () async => playing
                          ? await controller.pauseSurah()
                          : await controller.resumeSurah(),
                    );
                  },
                ),
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () async => controller.seekToPreviousAyah(),
                ),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  final double _selectedSpeed = 1.0;
  set selectedSpeed(double value) {
    selectedSpeed = value;
  }

  double get selectedSpeed => _selectedSpeed;

  Future<void> showPlaybackSpeedDialog(
      BuildContext context, void Function(double) onSpeedSelected) async {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('سرعة التشغيل', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final speed in speeds)
                RadioListTile<double>(
                  title: Text('${speed}x'),
                  value: speed,
                  groupValue: selectedSpeed,
                  onChanged: (value) {
                    if (value != null) {
                      selectedSpeed = value;
                      Navigator.of(context).pop();
                      onSpeedSelected(value);
                    }
                  },
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }
}
