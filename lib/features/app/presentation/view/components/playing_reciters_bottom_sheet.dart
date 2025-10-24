import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_audio_dwonload_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/surah_audio_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/current_reciter.dart';

class PlayingRecitersBottomSheet extends StatelessWidget {
  const PlayingRecitersBottomSheet({
    super.key,
    required this.controller,
    required this.surahAudioController,
  });

  final TafsirPageController controller;
  final SurahAudioController surahAudioController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Reciters List
          SizedBox(
            height: 180,
            child: ValueListenableBuilder(
                valueListenable: controller.recitersNotifier,
                builder: (_, List<ReciterEntity>? reciters, __) {
                  final List<ReciterEntity> availableReciters = reciters
                          ?.where((r) =>
                              r.surahAudioDownloadInfo != null &&
                              r.surahAudioDownloadInfo?.status ==
                                  SurahAudioDownloadStatus.complete)
                          .toList() ??
                      [];

                  if (availableReciters.isEmpty) {
                    return const Center(
                      child: Text(
                          "لا يوجد قراء متاحين، يمكنك تنزيل السوره بأكثر من قارئ"),
                    );
                  }

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: availableReciters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () => surahAudioController
                            .changeReciter(availableReciters[i]),
                        child: CurrentReciter(
                          reciter: availableReciters[i],
                          tafsirPageController: controller,
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
