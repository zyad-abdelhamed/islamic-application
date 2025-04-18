import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/features/app/presentation/view/components/draw_circle_line_bloc_builder.dart';
import 'package:test_app/features/app/presentation/view/components/rosary_ring_widget.dart';
import 'package:test_app/features/app/presentation/view/components/show_custom_alert_dialog.dart';
import 'package:test_app/features/app/presentation/view/components/custom_switch.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
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
          customPaintSize: context.width * .60,
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
        ...List<ShowCustomAlertDialog>.generate(
            textButtonsAlertDialogWidgets.length,
            (index) => ShowCustomAlertDialog(
                  text: ViewConstants.homeDrawerTextButtons[index],
                  alertDialogContent: textButtonsAlertDialogWidgets[index],
                )),
        Spacer(),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: CustomSwitch(
            title: 'الوضع الداكن',
            mainAxisAlignment: MainAxisAlignment.start,
            onChanged: (bool value) {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            value: context.themeController.darkMpde,
          ),
        ),
        SizedBoxs.sizedBoxH30
      ],
    );
  }
}
