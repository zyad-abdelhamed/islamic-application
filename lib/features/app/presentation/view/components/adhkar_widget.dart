import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/supplications_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/circle_avatar_button.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class AdhkarWidget extends StatelessWidget {
  final int index;
  final AdhkarEntity adhkarEntity;
  final AdhkarState state;
  const AdhkarWidget(
      {super.key,
      required this.index,
      required this.adhkarEntity,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: ViewConstants.mediumDuration,
      offset: state.adhkarWidgetsOffsets![index],
      child: Visibility(
        visible: state.adhkarWidgetsMaintainingSize![index],
        child: Column(
          spacing: 15.0,
           children: [
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
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey2),
                  child: AnimatedSlide(
                    duration: ViewConstants.lowDuration,
                    offset: state.selectedIndexOfChildAnimation != index
                        ? Offset.zero
                        : Offset(0, .3),
                    child: AnimatedOpacity(
                        opacity: state.selectedIndexOfChildAnimation != index
                            ? 1.0
                            : 0.0,
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
                circleAvatarButton(
                    context: context,
                    icon: Icons.minimize_outlined,
                    function: () {
                      context.supplicationsController
                          .decreaseCount(index: index);
                    }),
                circleAvatarButton(
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
}
