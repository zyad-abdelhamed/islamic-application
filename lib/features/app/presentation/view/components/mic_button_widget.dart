import 'package:flutter/material.dart';
import 'dart:math' as math;

class MicButtonWidget extends StatefulWidget {
  final bool isListening;
  final double soundLevel;
  final VoidCallback onTap;

  const MicButtonWidget({
    super.key,
    required this.isListening,
    required this.soundLevel,
    required this.onTap,
  });

  @override
  State<MicButtonWidget> createState() => _MicButtonWidgetState();
}

class _MicButtonWidgetState extends State<MicButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dynamicScale = widget.isListening
        ? 1 + (widget.soundLevel.clamp(0.0, 20.0) / 50)
        : 1.0;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          double pulse = 1 + 0.05 * math.sin(_controller.value * 2 * math.pi);
          double scale = widget.isListening ? pulse * dynamicScale : 1.0;

          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isListening
                    ? Colors.greenAccent.withOpacity(0.8)
                    : Colors.grey.shade800,
                boxShadow: widget.isListening
                    ? [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.7),
                          blurRadius: math.max(0, widget.soundLevel),
                          spreadRadius: math.max(0, widget.soundLevel / 4),
                        ),
                      ]
                    : [],
              ),
              child: const Icon(
                Icons.mic,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        },
      ),
    );
  }
}
