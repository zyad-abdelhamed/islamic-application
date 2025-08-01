
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
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
          AppStrings.nextPrayer,
          style: TextStyles.semiBold16(
            context: context,
            color: AppColors.grey400,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(
              right: 50), // التوغل لليسار (في RTL)
          child: BlocBuilder<PrayerTimesCubit, NextPrayer>(
            builder: (context, state) {
              return Text(
                "ال${state.name}",
                style: TextStyles.bold20(context).copyWith(
                  color: AppColors.secondryColor,
                  fontSize: 35,
                  fontFamily: 'DataFontFamily',
                  shadows: [
                    BoxShadow(
                      spreadRadius: 2,
                      offset: const Offset(-5.0, -5.0),
                      color:
                          AppColors.purple.withValues(alpha: 0.2),
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