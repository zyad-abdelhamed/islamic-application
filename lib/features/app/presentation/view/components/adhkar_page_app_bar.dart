import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';
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
      leading:
          const GetAdaptiveBackButtonWidget(backBehavior: BackBehavior.pop),
      actions: [
        ControleFontSizeButtons(
          fontSizeNotfier: adhkarPageController.fontSizeNotfier,
          initialFontSize: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: adhkarPageController.lengthNotfier,
            builder: (_, int value, ___) {
              final String currentCount = sl<BaseArabicConverterService>()
                  .convertToArabicDigits(value.toString());
              return Text(
                currentCount,
                style: TextStyles.semiBold16_120(context).copyWith(
                  color: context.isDarkMode ? Colors.black : Colors.white,
                  fontFamily: 'normal',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
