import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/speech_cubit.dart';
import 'mic_button_widget.dart';

class SpeechBottomBar extends StatelessWidget {
  final ValueNotifier<bool> hideTextNotifier;

  const SpeechBottomBar({super.key, required this.hideTextNotifier});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SpeechCubit>();

    return BlocBuilder<SpeechCubit, SpeechState>(
      builder: (context, state) {
        double soundLevel = 0;
        bool isListening = false;
        if (state is SpeechUpdated) {
          soundLevel = state.soundLevel;
          isListening = state.isListening;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            color: Color(0xFF1C4C48),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: hideTextNotifier,
                builder: (_, hide, __) => IconButton(
                  icon: Icon(
                    hide ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => hideTextNotifier.value = !hide,
                ),
              ),
              MicButtonWidget(
                isListening: isListening,
                soundLevel: soundLevel,
                onTap: () => isListening
                    ? cubit.stopListening()
                    : cubit.startListening(),
              ),
              const Icon(Icons.settings, color: Colors.white, size: 28),
            ],
          ),
        );
      },
    );
  }
}
