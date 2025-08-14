import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skeletons/skeletons.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/qibla_cubit.dart';

class QiplaAccuracyButton extends StatelessWidget {
  const QiplaAccuracyButton(
      {super.key, required this.state, this.isLoading = false});

  final QiblaLoaded state;
  final bool isLoading;
  String _accuracyToLabel(LocationAccuracy accuracy) {
    switch (accuracy) {
      case LocationAccuracy.low:
        return 'منخفضة';
      case LocationAccuracy.medium:
        return 'متوسطة';
      case LocationAccuracy.high:
        return 'عالية';
      case LocationAccuracy.best:
        return 'الأفضل';
      default:
        return 'غير محدد';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 1,
      children: [
        Text("مستوي الدقه"),
        GestureDetector(
          onTap: isLoading
              ? null
              : () => context.read<QiblaCubit>().changeAccuracy(state.accuracy),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: isLoading
                  ? SkeletonParagraph(
                      key: const ValueKey('loading'),
                      style: SkeletonParagraphStyle(
                        lines: 1,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 20,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 4,
                          maxLength: MediaQuery.of(context).size.width / 2,
                        ),
                      ),
                    )
                  : Text(
                      _accuracyToLabel(state.accuracy),
                      key: ValueKey(state.accuracy),
                      style: TextStyles.bold20(context)
                          .copyWith(color: AppColors.successColor),
                    )),
        ),
      ],
    );
  }
}
