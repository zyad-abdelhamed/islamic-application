import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/controle_font_size_buttons.dart';

class AdhkarPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final AdhkarPageController adhkarPageController;

  const AdhkarPageAppBar({
    super.key,
    required this.appBarTitle,
    required this.adhkarPageController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(appBarTitle),
      leading: const GetAdaptiveBackButtonWidget(),
      actions: [
        ControleFontSizeButtons(
          fontSizeNotfier: adhkarPageController.fontSizeNotfier,
          initialFontSize: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: adhkarPageController.lengthNotfier,
            builder: (_, __, ___) => Text(
              adhkarPageController.lengthNotfier.value.toString(),
              style: TextStyles.semiBold16_120(context).copyWith(
                color: ThemeCubit.controller(context).state
                    ? AppColors.darkModeTextColor
                    : AppColors.lightModeTextColor,
                fontFamily: 'normal',
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ValueListenableBuilder(
              valueListenable: adhkarPageController.switchNotfier,
              builder: (context, value, child) {
                return AdaptiveSwitch(
                  mainAxisAlignment: MainAxisAlignment.center,
                  name: AppStrings.translate("adhkarPageSwitchText"),
                  onChanged: (_) {
                    adhkarPageController.toggleIsDeletedSwitch();
                  },
                  value: adhkarPageController.switchNotfier.value,
                );
              }),
        ),
      ),
    );
  }

  /// لازم نحدد الـ preferredSize عشان الكلاس يشتغل كـ AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 72);
}
