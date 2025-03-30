import 'package:flutter/material.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/app/presentation/controller/cubit/supplications_cubit.dart';
import 'package:test_app/app/presentation/view/components/circle_avatar_button.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class SupplicationWidget extends StatelessWidget {
  final int index;
  final AdhkarEntity adhkarEntity;
  final SupplicationsState state;
  const SupplicationWidget(
      {super.key,
      required this.index,
      required this.adhkarEntity,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 15.0, children: [
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
              visible: adhkarEntity.description != null ,
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
                duration: ViewConstants.duration,
                offset: state.offset,
                child: AnimatedOpacity(
                    opacity: state.opacity,
                    duration: const Duration(seconds: 0),
                    child: Text(
                      adhkarEntity.count,
                      style: TextStyles.bold20(context).copyWith(fontSize: 25),
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
                  context.supplicationsController.decreaseCount(index: index,count: int.tryParse(adhkarEntity.count)!);
                }),
            circleAvatarButton(
              context: context,
              icon: Icons.loop,
              function: () {
                // context.supplicationsController
                //     .decreaseCount();
              },
            )
          ])
    ]);
  }
}
