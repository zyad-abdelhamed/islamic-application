import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/presentation/controller/controllers/surah_audio_controller.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/ayahs_flow_widget.dart';

class SurahPlayerBottomSheet extends StatefulWidget {
  final SurahAudioController controller;

  const SurahPlayerBottomSheet({super.key, required this.controller});

  @override
  State<SurahPlayerBottomSheet> createState() => _SurahPlayerBottomSheetState();
}

class _SurahPlayerBottomSheetState extends State<SurahPlayerBottomSheet> {
  double _selectedSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    final reciter =
        widget.controller.tafsirPageController.currentReciterNotifier.value;
    if (reciter == null) return const SizedBox.shrink();

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
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
                  onPressed: () => showPlaybackSpeedDialog(context),
                ),
              ],
            ),

            // صورة المقرئ
            ClipOval(
              child: Image.asset(
                reciter.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            // Marquee باسم السورة والمقرئ
            SizedBox(
              height: 48,
              child: Marquee(
                text:
                    "${reciter.name} - سورة ${widget.controller.tafsirPageController.surahEntity.name}",
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

            // AyahsFlowWidget
            AyahsFlowWidget(
              tafsirPageController: widget.controller.tafsirPageController,
            ),

            const Spacer(),

            // ProgressBar مع أرقام عربية
            StreamBuilder<ProgressData>(
              stream: widget.controller.progressStream,
              builder: (context, snapshot) {
                final ProgressData data = snapshot.data ??
                    ProgressData(
                        position: Duration.zero,
                        buffered: Duration.zero,
                        total: Duration.zero);

                final positionMs = (data.position.inMilliseconds
                        .clamp(0, data.total.inMilliseconds))
                    .toDouble();
                final totalMs = data.total.inMilliseconds.toDouble();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Slider RTL
                    Slider(
                      min: 0,
                      max: totalMs > 0 ? totalMs : 1.0,
                      value: positionMs,
                      onChanged: (value) async {
                        await widget.controller.audioPlayer
                            .seek(Duration(milliseconds: value.toInt()));
                      },
                    ),

                    // الوقت العربي أسفل Slider
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sl<BaseArabicConverterService>()
                                .convertTimeToArabic(
                                    data.position.toString().split('.').first),
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                          Text(
                            sl<BaseArabicConverterService>()
                                .convertTimeToArabic(
                                    data.total.toString().split('.').first),
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  onPressed: () async => widget.controller.seekToNextAyah(),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: widget.controller.isAudioPlayingNotifier,
                  builder: (context, playing, _) {
                    return IconButton(
                      iconSize: 80,
                      color: AppColors.primaryColor,
                      icon: Icon(playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill),
                      onPressed: () async => playing
                          ? await widget.controller.pauseSurah()
                          : await widget.controller.resumeSurah(),
                    );
                  },
                ),
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () async => widget.controller.seekToPreviousAyah(),
                ),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Dialog ضبط السرعة مع StatefulBuilder
  Future<void> showPlaybackSpeedDialog(BuildContext context) async {
    final List<double> speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    double tempSelectedSpeed = _selectedSpeed;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('سرعة التشغيل', textAlign: TextAlign.center),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final double speed in speeds)
                    RadioListTile<double>(
                      title: Text('${speed}x'),
                      value: speed,
                      groupValue: tempSelectedSpeed,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            tempSelectedSpeed = value;
                          });
                          widget.controller.setSpeed(value);
                          _selectedSpeed = value;

                          Navigator.of(context).pop();
                        }
                      },
                    ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('إلغاء'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
