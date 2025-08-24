import 'package:flutter/material.dart';

class VibrationButton extends StatelessWidget {
  final ValueNotifier<bool> vibrationNotifier;

  const VibrationButton({super.key, required this.vibrationNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: vibrationNotifier,
      builder: (_, value, __) {
        return IconButton(
          icon: Icon(value ? Icons.vibration : Icons.phonelink_erase),
          onPressed: () => vibrationNotifier.value = !value,
        );
      },
    );
  }
}
