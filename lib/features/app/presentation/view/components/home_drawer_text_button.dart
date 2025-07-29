import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
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
    const double spacing = 10.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => showCupertinoDialog(
            context: context,
            builder: (context) => BlocProvider(
                  create: (context) => AlertDialogCubit(),
                  child: CustomAlertDialog(
                      title: AppStrings.homeDrawerTextButtons[index],
                      alertDialogContent: (context) => alertDialogContent),
                )),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          color: ThemeCubit.controller(context).state ? AppColors.blueGrey800 : Color(0XFFE0F7FA),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: spacing,
              children: [
                Text(
                  AppStrings.done,
                  style: TextStyles.semiBold16_120(context)
                      .copyWith(color: AppColors.grey400),
                ),
                Text(
                  text,
                  style: TextStyles.semiBold16_120(context)
                      .copyWith(color: ThemeCubit.controller(context).state ? AppColors.darkModePrimaryColor : AppColors.lightModePrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
