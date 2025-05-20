import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/adhkar_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class AdhkarWidget extends StatelessWidget {
  
  const AdhkarWidget(
      {super.key,
      required this.index,
      required this.adhkarEntity,
      required this.state});

  final int index;
  final AdhkarEntity adhkarEntity;
  final AdhkarState state;    

  @override
  Widget build(BuildContext context) {
    const double countContainerHight = 40;
    const double countContainerWidth = 80;
    const double parentColumnSpacing = 15;
    const double childColumnSpacing = 5;

    return AnimatedSlide(
      duration: AppDurations.mediumDuration,
      offset: state.adhkarWidgetsOffsets![index],
      child: Visibility(
        visible: state.adhkarWidgetsMaintainingSize![index],
        child: Column(spacing: parentColumnSpacing, children: [
          Container(
            margin: EdgeInsets.only(
              top: index != 0 ? 30.0 : 0.0, //space between items
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.grey1,
            ),
            child: Column(
              spacing: childColumnSpacing,
              children: [
                Text(
                  adhkarEntity.content,
                  style: TextStyles.bold20(context),
                ),
                Visibility(
                  visible: adhkarEntity.description != null,
                  child: Text(
                    adhkarEntity.description!,
                    style: TextStyles.regular16_120(context,
                        color: AppColors.secondryColor),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: countContainerWidth,
                  height: countContainerHight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey2),
                  child: AnimatedSlide(
                    duration: AppDurations.lowDuration,
                    offset: state.selectedIndex != index
                        ? Offset.zero
                        : Offset(0, .3),
                    child: AnimatedOpacity(
                        opacity: state.selectedIndex != index ? 1.0 : 0.0,
                        duration: const Duration(seconds: 0),
                        child: Text(
                          state.adhkarcounts[index].toString(),
                          style:
                              TextStyles.bold20(context).copyWith(fontSize: 25),
                        )),
                  ),
                )
              ],
            ),
          ),
          Row(
              spacing: context.width * .10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <GestureDetector>[
                _circleAvatarButton(
                    context: context,
                    icon: Icons.minimize_outlined,
                    function: () {
                      context.supplicationsController
                          .decreaseCount(index: index);
                    }),
                _circleAvatarButton(
                  context: context,
                  icon: Icons.loop,
                  function: () {
                    context.supplicationsController
                        .resetCount(index: index, count: adhkarEntity.count);
                  },
                )
              ])
        ]),
      ),
    );
  }

  GestureDetector _circleAvatarButton(
        {required BuildContext context,
        required IconData icon,
        required VoidCallback function}) =>
    GestureDetector(
      onTap: function,
      child: CircleAvatar(
        backgroundColor: AppColors.inActivePrimaryColor,
        radius: getResponsiveFontSize(context: context, fontSize: 37),
        child: Icon(
          icon,
          size: getResponsiveFontSize(context: context, fontSize: 40),color: AppColors.primaryColor,
        ),
      ),
    );
}
