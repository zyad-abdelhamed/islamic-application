import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';

class NextPrayerWidget extends StatelessWidget {
  const NextPrayerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.translate("nextPrayer"),
          style: TextStyle(
            color: AppColors.grey400,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: BlocBuilder<PrayerTimesCubit, NextPrayer>(
            builder: (context, state) {
              return Text(
                "ال${state.name}",
                style: TextStyle(
                  color: AppColors.secondryColor,
                  fontSize: 35,
                  fontFamily: 'DataFontFamily',
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      spreadRadius: 2,
                      offset: const Offset(-5.0, -5.0),
                      color: context.watch<ThemeCubit>().state
                          ?  Color(0xFF80D8FF).withValues(alpha: 0.10)
                          : AppColors.purple.withValues(alpha: 0.2),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
