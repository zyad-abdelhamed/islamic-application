import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/features/app/presentation/view/components/draw_circle_line_bloc_builder.dart';
import 'package:test_app/features/app/presentation/view/components/rosary_ring_widget.dart';
import 'package:test_app/features/app/presentation/view/components/home_drawer_text_button.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/utils/sized_boxs.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<StatelessWidget> textButtonsAlertDialogWidgets =
        <StatelessWidget>[
      DrawCircleLineBlocBuilder(
          customPaintSize: 200,
          maxProgress: 100.0,
          functionality:
              DrawCircleLineBlocBuilderFunctionality.rosariesAfterPrayer),
      RosaryRingWidget(),
      Text(
        ViewConstants.khetmAlquran,
        textAlign: TextAlign.center,
        style:
            TextStyles.semiBold32auto(context).copyWith(color: AppColors.white),
      )
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...List<HomeDrawerTextButton>.generate(
            textButtonsAlertDialogWidgets.length,
            (index) => HomeDrawerTextButton(
                  text: ViewConstants.homeDrawerTextButtons[index],
                  alertDialogContent: textButtonsAlertDialogWidgets[index],
                )),
        Spacer(),
        Divider(),
        Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
                spacing: 10.0,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'الوضع الداكن',
                    style: TextStyles.bold20(context).copyWith(fontSize: 18),
                  ),
                  Switch.adaptive(
                      activeColor: AppColors.thirdColor,
                      activeTrackColor:
                          AppColors.thirdColor.withValues(alpha: .8),
                      inactiveThumbColor: AppColors.black,
                      inactiveTrackColor: AppColors.inActiveBlackColor,
                      value: context.themeController.darkMode,
                      onChanged: (bool value) =>
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme())
                ])),
        SizedBoxs.sizedBoxH30
      ],
    );
  }
}
