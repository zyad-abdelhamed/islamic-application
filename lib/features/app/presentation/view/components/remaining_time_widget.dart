import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';
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
            spacing: 8.0,
            children: [
              /// عنوان
              Flexible(
                child: Text(
                  AppStrings.translate("remainingTime"),
                  style: context.labelLarge,
                ),
              ),

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
                        mainAxisAlignment: MainAxisAlignment.center,
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
