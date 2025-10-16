import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/presentation/view/components/is_playing_animation.dart';

class CurrentReciter extends StatelessWidget {
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ReciterEntity reciter;
  final double size;
  CurrentReciter({
    super.key,
    required this.reciter,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // الخلفية بالصورة
            Positioned.fill(
              child: Image.asset(
                reciter.image,
                fit: BoxFit.cover,
              ),
            ),

            // التدرّج الأسود من تحت لفوق
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.7],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.darken,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),

            // المحتوى
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ValueListenableBuilder(
                      valueListenable: isPlayingNotifier,
                      builder: (context, value, child) {
                        return Visibility(
                          visible: value,
                          child: IsPlayingAnimation(isActive: value),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    reciter.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.bold20(context)
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    reciter.language,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.semiBold18(
                      context,
                      AppColors.darkModeScaffoldBackGroundColor,
                    ).copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
