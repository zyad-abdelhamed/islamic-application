import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/presentation/controller/cubit/allah_names_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/allah_names_state.dart';
import 'package:test_app/features/app/presentation/view/components/favorite_button.dart';
import 'package:test_app/features/app/presentation/view/components/play_button.dart';

class RandomAllahNameCard extends StatelessWidget {
  const RandomAllahNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllahNamesCubit>(
      create: (_) => AllahNamesCubit()..init(),
      child: BlocBuilder<AllahNamesCubit, AllahNamesState>(
        buildWhen: (previous, current) => current is GetRandomAllahName,
        builder: (context, state) {
          if (state is GetRandomAllahName) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: Container(
                key: ValueKey(state.current.name),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.secondryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name
                    Text(
                      state.current.name,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Transliteration
                    Text(
                      state.current.transliteration,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Meaning
                    Text(
                      state.current.meaning,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Text(
                      state.current.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.85),
                        height: 1.5, // spacing احترافي
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 20),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Favorite Button
                        FavoriteButton<AllahNamesCubit, AllahNamesState>(
                          initialFavorite: state.current.isFavorite,
                          toggleFavorite: (isFavorite) =>
                              AllahNamesCubit.get(context).toggleFavorite(),
                          listener: (ctx, state, runAnimation) {
                            if (state
                                is AllahNamesStateIsToggleFavoriteSuccess) {
                              runAnimation();
                            }

                            if (state is AllahNamesStateIsToggleFavoriteError) {
                              AppSnackBar(
                                message: state.message,
                                type: AppSnackBarType.error,
                              ).show(context);
                            }
                          },
                        ),

                        // Audio Button
                        PlayButton(
                          player: JustAudioPlayer(AudioPlayer()),
                          audioSource: AudioSource.uri(
                            Uri.parse(state.current.audioUrl),
                          ),
                        ),

                        // Refresh Button
                        IconButton(
                          iconSize: 48,
                          color: Colors.white,
                          icon: const Icon(Icons.refresh),
                          onPressed: () =>
                              AllahNamesCubit.get(context).getRandomName(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
