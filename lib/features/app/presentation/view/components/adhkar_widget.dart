import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class AdhkarWidget extends StatefulWidget {
  const AdhkarWidget(
      {super.key,
      required this.index,
      required this.adhkarEntity,
      required this.adhkarPageController});

  final int index;
  final AdhkarEntity adhkarEntity;
  final AdhkarPageController adhkarPageController;

  @override
  State<AdhkarWidget> createState() => _AdhkarWidgetState();
}

class _AdhkarWidgetState extends State<AdhkarWidget> {
  @override
  Widget build(BuildContext context) {
    const double countContainerHight = 40;
    const double countContainerWidth = 80;
    const double parentColumnSpacing = 15;
    const double childColumnSpacing = 5;

    return Column(
        key: ObjectKey(widget.adhkarEntity),
        spacing: parentColumnSpacing,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: widget.index != 0 ? 30.0 : 0.0, //space between items
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.grey1,
            ),
            child: Column(
              spacing: childColumnSpacing,
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: widget.adhkarPageController.fontSizeNotfier,
                  builder: (_, __, ___) => Column(
                    spacing: childColumnSpacing,
                    children: [
                      Text(
                        widget.adhkarEntity.content,
                        style: TextStyles.bold20(context).copyWith(
                            fontFamily: 'DataFontFamily',
                            color: ThemeCubit.controller(context).state
                                ? AppColors.grey400
                                : Colors.black,
                            fontSize: widget
                                .adhkarPageController.fontSizeNotfier.value),
                      ),
                      Visibility(
                        visible: widget.adhkarEntity.description != null,
                        child: Text(
                          widget.adhkarEntity.description!,
                          style: TextStyles.regular16_120(context,
                                  color: AppColors.secondryColor)
                              .copyWith(fontFamily: 'Amiri',
                                  fontSize: (widget.adhkarPageController
                                          .fontSizeNotfier.value) -
                                      4),
                        ),
                      ),
                    ],
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
                  child: ValueListenableBuilder<NumberAnimationModel>(
                    valueListenable: widget.adhkarEntity.countNotifier,
                    builder: (context, value, _) => AnimatedSlide(
                      duration: AppDurations.lowDuration,
                      offset: widget.adhkarEntity.countNotifier.value.offset!,
                      child: AnimatedOpacity(
                          opacity:
                              widget.adhkarEntity.countNotifier.value.opacity!,
                          duration: const Duration(seconds: 0),
                          child: Text(
                            widget.adhkarEntity.countNotifier.value.number
                                .toString(),
                            style: TextStyles.bold20(context).copyWith(
                                fontSize: 25,
                                color: ThemeCubit.controller(context).state
                                    ? AppColors.grey400
                                    : Colors.black,
                                fontFamily: 'normal'),
                          )),
                    ),
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
                      widget.adhkarPageController.decreaseCount(
                          countPrameters: CountPrameters(
                              index: widget.index,
                              adhkarEntity: widget.adhkarEntity,
                              countNotifier:
                                  widget.adhkarEntity.countNotifier));
                    }),
                _circleAvatarButton(
                  context: context,
                  icon: Icons.loop,
                  function: () {
                    widget.adhkarPageController.resetCount(
                        countPrameters: CountPrameters(
                            index: widget.index,
                            adhkarEntity: widget.adhkarEntity,
                            countNotifier: widget.adhkarEntity.countNotifier));
                  },
                )
              ])
        ]);
  }

  GestureDetector _circleAvatarButton(
          {required BuildContext context,
          required IconData icon,
          required VoidCallback function}) =>
      GestureDetector(
        onTap: function,
        child: CircleAvatar(
          backgroundColor: ThemeCubit.controller(context).state ? AppColors.darkModeInActiveColor : AppColors.lightModeInActiveColor,
          radius: getResponsiveFontSize(context: context, fontSize: 37),
          child: Icon(
            icon,
            size: getResponsiveFontSize(context: context, fontSize: 40),
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
}
