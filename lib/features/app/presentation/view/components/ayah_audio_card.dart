import 'package:flutter/material.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/ayah_audio_card_controller.dart';

class AyahAudioCard extends StatelessWidget {
  final AyahAudioCardController controller;
  final String reciterName;
  final String reciterImageUrl;

  const AyahAudioCard({
    super.key,
    required this.controller,
    required this.reciterName,
    required this.reciterImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: controller.offset,
      builder: (_, offset, __) => Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
          onPanUpdate: (details) => controller.updateOffset(details.delta),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.grey2,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              width: context.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(reciterImageUrl),
                        radius: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          reciterName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.grey,),
                        onPressed: controller.removeCard,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<Duration>(
                    valueListenable: controller.position,
                    builder: (_, pos, __) => Slider(
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.primaryColorInActiveColor,
                      value: pos.inSeconds.toDouble(),
                      max: 1.0, // يمكن تعديله حسب مدة الصوت
                      onChanged: (val) =>
                          controller.seek(Duration(seconds: val.toInt())),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder<PlayerStatus>(
                        valueListenable: controller.status,
                        builder: (_, status, __) => IconButton(
                          icon: Icon(
                            status == PlayerStatus.playing
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: AppColors.primaryColor,
                          ),
                          iconSize: 56,
                          onPressed: controller.togglePlayPause,
                        ),
                      ),
                      ValueListenableBuilder<double>(
                        valueListenable: controller.speed,
                        builder: (_, speed, __) {
                          final speeds = [0.5, 1.0, 1.5, 2.0];
                          final currentIndex = speeds.indexOf(speed);
                          final nextIndex = (currentIndex + 1) % speeds.length;
                          final nextSpeed = speeds[nextIndex];

                          return GestureDetector(
                            onTap: () => controller.setSpeed(nextSpeed),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.secondryColorInActiveColor,
                                shape: BoxShape.circle
                              ),
                              child: Text(
                                "${speed}x",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondryColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
