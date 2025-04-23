import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

class HomeDrawerTextButton extends StatelessWidget {
  final String text;
  final Widget alertDialogContent;
  const HomeDrawerTextButton({
    super.key,
    required this.text,
    required this.alertDialogContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5.0,
            backgroundColor: AppColors.secondryColor,
          ),
          TextButton(
            onPressed: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => BlocProvider(
                        create: (context) => AlertDialogCubit(),
                        child: CustomAlertDialog(
                            alertDialogContent: (context) => alertDialogContent),
                      ));
            },
            child: Text(
              text,
              style: TextStyles.semiBold16_120(context).copyWith(
                  color: context.themeController.darkMode
                      ? AppColors.white
                      : AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
