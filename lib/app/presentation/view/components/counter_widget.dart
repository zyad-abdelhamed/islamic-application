import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.width * (1 / 3) / 2),
      child: SizedBox(
        height: context.height * (1 / 3) / 2 + 80,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                alignment: Alignment.center,
                width: context.width * 2 / 3,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: BlocBuilder<ElecRosaryCubit, ElecRosaryState>(
                    builder: (context, state) {
                  print('ElecRosaryCubit rebuild');
                  return AnimatedSlide(
                      duration: ViewConstants.duration,
                      offset: state.offset,
                      child: AnimatedOpacity(
                        opacity: state.opacity,
                        duration: const Duration(seconds: 0),
                        child: Text(
                          state.counter.toString(),
                          style: TextStyles.semiBold32(context,
                              color: AppColors.white),
                        ),
                      ));
                })),
            Positioned(
              top: 80 + 15, //80 for container hight and 15 for spacing.
              right: 0.0,
              child: GestureDetector(
                onTap: () => context.elecRosaryController.resetCounter(),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: const CircleAvatar(
                    backgroundColor: AppColors.secondryColor,
                    radius: 10,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80 + 15, //80 for container hight and 15 for spacing.
              left: 0.0, right: 0.0,
              child: GestureDetector(
                onTap: () {
                  context.elecRosaryController.increaseCounter();
                },
                child: CircleAvatar(
                  radius: context.width * (1 / 3) / 2,
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
