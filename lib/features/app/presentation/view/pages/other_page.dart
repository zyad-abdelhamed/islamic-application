import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/other_page_button.dart';
import 'package:test_app/features/app/presentation/view/components/post_prayer_adhkar_widget.dart';
import 'package:test_app/features/app/presentation/view/components/rosary_ring%20widget.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List textButtonsAlertDialogWidgets = [
      Text(
        AppStrings.translate("khetmAlquran"),
        textAlign: TextAlign.center,
        style: TextStyles.bold20(context).copyWith(
          fontFamily: 'DataFontFamily',
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey
              : Colors.black,
        ),
      ),
      DrawRosaryRingWidget(),
      PostPrayerAdhkarWidget(),
    ];

    const double spacing = 10.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appBarTitles(withTwoLines: false)[7]),
        leading: const GetAdaptiveBackButtonWidget(),
      ),
      body: Center(
        child: GridView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(spacing),
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            childAspectRatio: 0.75,
          ),
          children:
              List.generate(textButtonsAlertDialogWidgets.length, (index) {
            return OtherPageButton(
              text: AppStrings.translate("homeDrawerTextButtons")[index],
              logo: AppStrings.translate("otherPagePhotos")[index],
              size: MediaQuery.of(context).size.width * 0.27,
              alertDialogContent: textButtonsAlertDialogWidgets[index],
            );
          }),
        ),
      ),
    );
  }
}
