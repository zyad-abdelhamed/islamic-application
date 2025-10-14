import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/file_storage_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:just_audio/just_audio.dart';

class PlaySurahAudioWidget extends StatefulWidget {
  final double imageSize;
  final TafsirPageController controller;

  const PlaySurahAudioWidget({
    super.key,
    this.imageSize = 50,
    required this.controller,
  });

  @override
  State<PlaySurahAudioWidget> createState() => _PlaySurahAudioWidgetState();
}

class _PlaySurahAudioWidgetState extends State<PlaySurahAudioWidget> {
  late final IAudioPlayer audioPlayer;
  late final IFileStorageService fileStorage;
  late final List<Duration> ayahDurations;

  @override
  void initState() {
    super.initState();
    audioPlayer = sl<IAudioPlayer>();
    fileStorage = sl<IFileStorageService>();
    ayahDurations = [];
  }

  Future<void> _prepareSurahAudio() async {
    final reciter = widget.controller.currentReciterNotifier.value;
    if (reciter == null) return;

    final folderName = "${reciter.name}_${widget.controller.surahEntity.name}";
    final totalAyahs = widget.controller.surahEntity.numberOfAyat;
    if (totalAyahs <= 0) return;

    widget.controller.isAudioPlayingNotifier.value = false;
    widget.controller.selectedAyah.value = null;

    final resolvedFiles = await Future.wait(
      List.generate(
        totalAyahs,
        (i) => fileStorage.getFile(
          folderName: folderName,
          fileName: '${i + 1}',
          extension: 'mp3',
        ),
      ),
    );

    ayahDurations = await Future.wait(
      resolvedFiles.map((file) async {
        final tempPlayer = AudioPlayer();
        await tempPlayer.setFilePath(file.path);
        final duration = tempPlayer.duration ?? Duration.zero;
        await tempPlayer.dispose();
        return duration;
      }),
    );

    final sources = await Future.wait(
      resolvedFiles
          .map((file) => Future.value(AudioSource.uri(Uri.file(file.path)))),
    );

    final duration = await audioPlayer.setAudioSources(sources);
    await audioPlayer.play();

    widget.controller.isAudioPlayingNotifier.value = true;

    widget.controller.audioPositionStream =
        audioPlayer.positionStream.map<double>((pos) {
      Duration cumulative = Duration.zero;
      int currentAyah = 1;

      for (int i = 0; i < ayahDurations.length; i++) {
        cumulative += ayahDurations[i];
        if (pos < cumulative) {
          currentAyah = i + 1;
          break;
        }
      }

      widget.controller.selectedAyah.value = currentAyah;

      final totalMs = duration?.inMilliseconds ?? cumulative.inMilliseconds;
      return (pos.inMilliseconds / totalMs).clamp(0.0, 1.0);
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.status == PlayerStatus.completed) {
        widget.controller.isAudioPlayingNotifier.value = false;
        widget.controller.selectedAyah.value = null;
        audioPlayer.stop();
      }
    });
  }

  Future<void> _resumeSurah() async {
    widget.controller.isAudioPlayingNotifier.value = true;
    await audioPlayer.play();
  }

  Future<void> _stopSurah() async {
    widget.controller.isAudioPlayingNotifier.value = false;
    await audioPlayer.stop();
  }

  void _openBottomSheet(BuildContext context) {
    final reciter = widget.controller.currentReciterNotifier.value;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Center(
          child: Text(
            "تشغيل سورة ${widget.controller.surahEntity.name} بصوت ${reciter?.name ?? "غير متاح"}",
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ReciterEntity?>(
      valueListenable: widget.controller.currentReciterNotifier,
      builder: (context, reciter, child) {
        final isActive = reciter != null;

        return AbsorbPointer(
          absorbing: !isActive,
          child: Opacity(
            opacity: isActive ? 1.0 : 0.5,
            child: ListTile(
              onTap: isActive ? () => _openBottomSheet(context) : null,
              leading: StreamBuilder<double>(
                stream: widget.controller.audioPositionStream,
                builder: (_, snapshot) {
                  final progress = snapshot.data ?? 0.0;
                  return CircularPercentIndicator(
                    radius: widget.imageSize,
                    lineWidth: 4,
                    percent: progress,
                    backgroundColor: Colors.grey.shade400,
                    progressColor: AppColors.primaryColor,
                    center: ValueListenableBuilder<bool>(
                      valueListenable: widget.controller.isAudioPlayingNotifier,
                      builder: (_, isPlaying, __) {
                        return IconButton(
                          icon: Icon(
                            isPlaying
                                ? CupertinoIcons.pause
                                : CupertinoIcons.play_arrow_solid,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: isPlaying ? _stopSurah : _resumeSurah,
                        );
                      },
                    ),
                  );
                },
              ),
              title: Text(reciter?.name ?? "غير متاح"),
              subtitle: ValueListenableBuilder<int?>(
                valueListenable: widget.controller.selectedAyah,
                builder: (_, ayah, __) => Text(
                  ayah != null
                      ? "الآية الحالية: $ayah"
                      : reciter?.language ?? "",
                ),
              ),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.headphones,
                    color: AppColors.primaryColor),
                onPressed: _prepareSurahAudio,
              ),
            ),
          ),
        );
      },
    );
  }
}
