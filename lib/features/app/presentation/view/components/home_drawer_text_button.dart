import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

class HomeDrawerTextButton extends StatelessWidget {
  const HomeDrawerTextButton({
    super.key,
    required this.text,
    required this.alertDialogContent,
    required this.index,
    required this.icon,
  });

  final int index;
  final String text;
  final Widget alertDialogContent;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemeCubit.controller(context).state;

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => BlocProvider(
          create: (_) => AlertDialogCubit(),
          child: CustomAlertDialog(
            title: AppStrings.homeDrawerTextButtons[index],
            alertDialogContent: (_) => alertDialogContent,
            iconWidget: (_) => icon,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.blueGrey800
              : Color(0XFFE0F7FA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.secondryColor.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyles.semiBold16_120(context).copyWith(
                  color: isDark
                      ? AppColors.darkModePrimaryColor
                      : AppColors.lightModePrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
