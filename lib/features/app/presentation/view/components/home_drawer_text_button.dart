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
  });

  final int index;
  final String text;
  final Widget alertDialogContent;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeCubit.controller(context).state;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => BlocProvider<AlertDialogCubit>(
            create: (_) => AlertDialogCubit(),
            child: CustomAlertDialog(
              title: AppStrings.homeDrawerTextButtons[index],
              alertDialogContent: (_) => alertDialogContent,
              iconWidget: (_) => const Icon(
                Icons.book,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppColors.darkModeTextColor : AppColors.lightModeTextColor,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyles.semiBold20(context).copyWith(
                color: isDark
                    ? AppColors.darkModeTextColor
                    : AppColors.lightModeTextColor,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

