import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

class DownloadIconWithLoadingEffect extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const DownloadIconWithLoadingEffect({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  State<DownloadIconWithLoadingEffect> createState() =>
      _DownloadIconWithLoadingEffectState();
}

class _DownloadIconWithLoadingEffectState
    extends State<DownloadIconWithLoadingEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    if (widget.isLoading) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant DownloadIconWithLoadingEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isLoading && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIconWithEffect() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.download, size: 28, color: Colors.white),
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    _controller.value - 0.35,
                    _controller.value,
                    _controller.value + 0.35
                  ],
                  colors: [
                    Colors.transparent,
                    AppColors.successColor,
                    Colors.transparent,
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: const Icon(Icons.download, size: 28, color: Colors.white),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        icon: widget.isLoading
            ? _buildIconWithEffect()
            : const Icon(Icons.download, size: 28, color: Colors.white),
        onPressed: widget.onPressed,
      ),
    );
  }
}
