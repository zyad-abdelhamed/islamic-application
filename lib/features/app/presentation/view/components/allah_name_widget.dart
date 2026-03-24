import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/allah_name.dart';
import 'package:test_app/features/app/presentation/controller/cubit/allah_names_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/allah_names_state.dart';
import 'package:test_app/features/app/presentation/view/components/play_button.dart';

class AllahNameWidget extends StatefulWidget {
  final AllahNameEntity entity;
  final int index;

  const AllahNameWidget({
    super.key,
    required this.entity,
    required this.index,
  });

  @override
  State<AllahNameWidget> createState() => _AllahNameWidgetState();
}

class _AllahNameWidgetState extends State<AllahNameWidget>
    with SingleTickerProviderStateMixin {
  late bool isFav;
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    isFav = widget.entity.isFavorite;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1,
      upperBound: 1.1,
    );

    _scale = Tween(begin: 1.0, end: 1.1).animate(_controller);
  }

  void runFavoriteAnimation() {
    setState(() {
      isFav = !isFav;
    });

    _controller.forward().then((_) => _controller.reverse());
  }

  void openDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _DetailsPage(entity: widget.entity),
      ),
    );
  }

  void showDescription() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(widget.entity.name),
        content: Text(widget.entity.description),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AllahNamesCubit, AllahNamesState>(
      listener: (ctx, state) {
        if (state is AllahNamesStateIsToggleFavoriteSuccess) {
          runFavoriteAnimation();
        }

        if (state is AllahNamesStateIsToggleFavoriteError) {
          AppSnackBar(
            message: state.message,
            type: AppSnackBarType.error,
          ).show(context);
        }
      },
      child: ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onDoubleTap: () => AllahNamesCubit.get(context).toggleFavorite(),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: isFav
                    ? [
                        AppColors.primaryColor,
                        AppColors.secondryColor,
                      ]
                    : [
                        Colors.grey.shade200,
                        Colors.grey.shade300,
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                /// 🔢 الرقم (يمين فوق)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Text(
                    sl<BaseArabicConverterService>()
                        .convertToArabicDigits((widget.index + 1).toString()),
                    style: TextStyle(
                      color: isFav ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /// 💚 Favorite Icon (يظهر بس لو مفضل)
                if (isFav)
                  const Positioned(
                    left: 0,
                    top: 0,
                    child: Icon(Icons.favorite, color: Colors.white),
                  ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// الاسم العربي
                    Text(
                      widget.entity.name,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isFav ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    /// transliteration
                    Text(
                      widget.entity.transliteration,
                      style: TextStyle(
                        fontSize: 14,
                        color: isFav ? Colors.white70 : Colors.black54,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// meaning
                    Text(
                      widget.entity.meaning,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: isFav ? Colors.white70 : Colors.black45,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const AppDivider(),

                    const SizedBox(height: 10),

                    /// actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 🔙 arrow → description
                        IconButton(
                          onPressed: showDescription,
                          icon: Icon(
                            Icons.arrow_back,
                            color: isFav ? Colors.white : Colors.black,
                          ),
                        ),

                        PlayButton(
                          player: JustAudioPlayer(AudioPlayer()),
                          audioSource: AudioSource.uri(
                            Uri.parse(widget.entity.audioUrl),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///  Hero Details Page
class _DetailsPage extends StatelessWidget {
  final AllahNameEntity entity;

  const _DetailsPage({required this.entity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: entity.name,
          child: Material(
            color: Colors.transparent,
            child: Text(
              entity.name,
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }
}
