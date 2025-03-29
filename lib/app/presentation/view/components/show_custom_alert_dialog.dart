import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class ShowCustomAlertDialog extends StatelessWidget {
  final String text;
  final Widget alertDialogContent;
  const ShowCustomAlertDialog({
    super.key,
    required this.text,
    required this.alertDialogContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5.0,
            backgroundColor: AppColors.primaryColor,
          ),
          TextButton(
            onPressed: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => BlocProvider(
                        create: (context) => AlertDialogCubit(),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: context.width * .50,
                              left: 15.0,
                              right: 15.0,
                              bottom: 15.0),
                          height: (context.height * .50) - 15.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: context.themeController.darkMpde
                                ? AppColors.black
                                : AppColors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            spacing: 15.0,
                            children: [
                              SizedBox(
                                height: (context.height * .10) - 15.0,
                          width: double.infinity,
                               ),
                              alertDialogContent,
                              Spacer(),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'ْالغاء',
                                  style: TextStyles.semiBold20(context)
                                      .copyWith(color: AppColors.thirdColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
            },
            child: Text(
              text,
              style: TextStyles.semiBold20(context).copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColors.thirdColor),
            ),
          ),
        ],
      ),
    );
  }
}
