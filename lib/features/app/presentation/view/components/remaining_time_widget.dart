import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/time_style_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/display_time_container.dart';
import 'package:test_app/features/app/presentation/view/components/time_style_switcher.dart';

class RemainingTimeWidget extends StatelessWidget {
  const RemainingTimeWidget({super.key});
  final double borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeStyleCubit>(
      create: (_) => TimeStyleCubit(),
      child: BlocBuilder<TimeStyleCubit, TimeNumberStyle>(
        builder: (context, currStyle) {
          return Row(
            children: [
              const SizedBox(width: 10),

              /// عنوان
              Text(
                AppStrings.translate("remainingTime"),
                style: TextStyles.bold20(context),
              ),

              const SizedBox(width: 8),

              /// عرض الوقت
              SizedBox(
                height: 60,
                width: 60 * 3,
                child: Stack(
                  children: [
                    Row(
                      children: List.generate(
                        3,
                        (index) => DisplayTimeContainer(
                          index: index,
                          currentTimeStyle: currStyle,
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        children: List.generate(
                          2,
                          (_) => const SizedBox(
                            height: 60,
                            width: 60,
                            child: VerticalDivider(
                              thickness: 3,
                              indent: 10,
                              endIndent: 10,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              /// زر تغيير شكل الأرقام
              TimeStyleSwitcher(
                currentStyle: currStyle,
              ),
            ],
          );
        },
      ),
    );
  }
}
