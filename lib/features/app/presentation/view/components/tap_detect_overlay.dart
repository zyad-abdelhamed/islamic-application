import 'package:flutter/material.dart';

/// Overlay يلتقط الضغطات (Tap) من غير ما يمنع الـ Scroll
class TapDetectOverlay extends StatefulWidget {
  final VoidCallback onTap;
  final double maxMovement;
  final Duration maxDuration;

  const TapDetectOverlay({
    required this.onTap,
    this.maxMovement = 8.0,
    this.maxDuration = const Duration(milliseconds: 220),
    super.key,
  });

  @override
  State<TapDetectOverlay> createState() => _TapDetectOverlayState();
}

class _TapDetectOverlayState extends State<TapDetectOverlay> {
  Offset? _downPos;
  DateTime? _downTime;

  void _onPointerDown(PointerDownEvent event) {
    _downPos = event.position;
    _downTime = DateTime.now();
  }

  void _onPointerUp(PointerUpEvent event) {
    if (_downPos == null || _downTime == null) {
      _clear();
      return;
    }
    final dt = DateTime.now().difference(_downTime!);
    final dist = (event.position - _downPos!).distance;
    if (dt <= widget.maxDuration && dist <= widget.maxMovement) {
      widget.onTap();
    }
    _clear();
  }

  void _onPointerCancel(PointerCancelEvent event) => _clear();

  void _clear() {
    _downPos = null;
    _downTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: Container(color: Colors.transparent),
    );
  }
}
