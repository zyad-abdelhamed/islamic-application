import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/features/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (250 * 1/2)+ 15 + 80,//hight of container and spacing between (container and circle avatar) and circle avatar
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              width: 250,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(18)),
              ),
              child: BlocBuilder<ElecRosaryCubit, ElecRosaryState>(
                  builder: (context, state) {
                print('ElecRosaryCubit rebuild');
                return AnimatedSlide(
                    duration: AppDurations.lowDuration,
                    offset: state.offset,
                    child: AnimatedOpacity(
                      opacity: state.opacity,
                      duration: const Duration(seconds: 0),
                      child: Text(
                        context.elecRosaryController.counter.toString(),
                        style: TextStyles.semiBold32(context,
                            color: _getCounterColor(context)),
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
                radius: (250 * 1/2) / 2,//half of counter container
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          //save button
          Positioned(
            top: 0.0,
            right: 20,
            child: GestureDetector(
              onTap: () {
                context.featuerdRecordsController.addFeatuerdRecord(context: context,
                    item: context.elecRosaryController.counter);
                    
              },
              child: Container(
                height: 60,
                width: 50,
                color: _getCounterColor(context),
                child: FittedBox(
                  child: Icon(
                    Icons.save,
                    color: AppColors.primaryColor,
                    size: getResponsiveFontSize(context: context, fontSize: 50),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _getCounterColor(BuildContext context) =>
   context.themeController.state
        ? AppColors.black
        : AppColors.white;
