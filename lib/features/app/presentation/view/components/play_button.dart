import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/theme/app_colors.dart';

class PlayButton extends StatefulWidget {
  final bool initialValue;
  final IAudioPlayer player;
  final AudioSource? audioSource;

  const PlayButton({
    super.key,
    this.initialValue = false,
    required this.player,
    this.audioSource,
  });

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late bool isAudioPlaying;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    isAudioPlaying = widget.initialValue;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.2,
    );

    _scaleAnimation = _controller.drive(Tween(begin: 1.0, end: 1.2));
  }

  void runAnimation() {
    setState(() {
      isAudioPlaying = !isAudioPlaying;
    });

    // simple scale effect
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        iconSize: 48,
        color: AppColors.primaryColor,
        icon: Icon(
          isAudioPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
        ),
        onPressed: () async {
          try {
            // first to set audio file if needed
            widget.audioSource != null
                ? widget.player.setAudioSource(widget.audioSource!)
                : null;

            // then to play
            if (isAudioPlaying) {
              await widget.player.pause();
            } else {
              await widget.player.play();
            }
          } on Exception catch (_) {
            return;
          }

          runAnimation();
        },
      ),
    );
  }
}
