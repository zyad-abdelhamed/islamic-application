import 'package:flutter/material.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/ayah_audio_card_controller.dart';

class AyahAudioCard extends StatefulWidget {
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
  State<AyahAudioCard> createState() => _AyahAudioCardState();
}

class _AyahAudioCardState extends State<AyahAudioCard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: widget.controller.offset,
      builder: (_, offset, __) => Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
          onPanUpdate: (details) =>
              widget.controller.updateOffset(details.delta),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          widget.reciterImageUrl,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.reciterName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        onPressed: widget.controller.removeCard,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<PlayerStatus>(
                    valueListenable: widget.controller.status,
                    builder: (_, status, __) =>
                        ValueListenableBuilder<Duration>(
                      valueListenable: widget.controller.position,
                      builder: (_, pos, __) => ValueListenableBuilder<Duration>(
                        valueListenable: widget.controller.duration,
                        builder: (_, dur, __) {
                          final speeds = [0.5, 1.0, 1.5, 2.0];
                          final currentSpeed = widget.controller.speed.value;
                          final currentIndex = speeds.indexOf(currentSpeed);
                          final nextIndex = (currentIndex + 1) % speeds.length;
                          final nextSpeed = speeds[nextIndex];

                          return Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: IconButton(
                                  icon: Icon(
                                    status == PlayerStatus.playing
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_fill,
                                  ),
                                  iconSize: 48,
                                  onPressed: widget.controller.togglePlayPause,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Slider(
                                  activeColor: AppColors.primaryColor,
                                  inactiveColor:
                                      AppColors.primaryColorInActiveColor,
                                  value: pos.inSeconds
                                      .toDouble()
                                      .clamp(0.0, dur.inSeconds.toDouble()),
                                  max: dur.inSeconds.toDouble(),
                                  onChanged: (val) => widget.controller.seek(
                                    Duration(seconds: val.toInt()),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () =>
                                      widget.controller.setSpeed(nextSpeed),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.secondryColorInActiveColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "${currentSpeed}x",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
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
