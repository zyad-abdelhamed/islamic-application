import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

AppBar adhkarPageAppBar(BuildContext context,
    {required String appBarTitle,
    required AdhkarPageController adhkarPageController}) {
  final List<Map<String, dynamic>> controleTextFontSizeButtonsData = [
    {
      "onTap": adhkarPageController.increaseFontSize,
      "fontSize": 23.0.toDouble()
    },
    {
      "onTap": adhkarPageController.decreaseFontSize,
      "fontSize": 18.0.toDouble()
    }
  ];
  return AppBar(
    centerTitle: false,
    title: FittedBox(fit: BoxFit.scaleDown, child: Text(appBarTitle)),
    leading: GetAdaptiveBackButtonWidget(),
    actions: [
      Row(
        spacing: 10.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            2,
            (index) => _controleTextFontSizeButton(context,
                fontSize: controleTextFontSizeButtonsData[index]["fontSize"],
                onTap: controleTextFontSizeButtonsData[index]["onTap"])),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
        decoration: BoxDecoration(
            color: AppColors.primaryColor(context),
            borderRadius: BorderRadius.circular(8.0)),
        child: ValueListenableBuilder<int>(
            valueListenable: adhkarPageController.lengthNotfier,
            builder: (_, __, ___) => Text(
                  adhkarPageController.lengthNotfier.value.toString(),
                  style: TextStyles.semiBold16_120(context)
                      .copyWith(color: Colors.black),
                )),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ValueListenableBuilder(
              valueListenable: adhkarPageController.switchNotfier,
              builder: (_, __, ___) => AdaptiveSwitch(
                  name: AppStrings.adhkarPageSwitchText,
                  onChanged: adhkarPageController.toggleIsDeletedSwitch,
                  value: adhkarPageController.switchNotfier.value))),
    ),
  );
}

GestureDetector _controleTextFontSizeButton(BuildContext context,
    {required double fontSize, required void Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(AppStrings.fontSizeButtonText,
        style: TextStyles.bold20(context).copyWith(
            color: Colors.grey, fontSize: fontSize, fontFamily: "normal")),
  );
}
