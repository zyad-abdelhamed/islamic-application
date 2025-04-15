import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
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
      padding: const EdgeInsets.only(right: 8.0),
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
                        child: CustomAlertDialog(alertDialogContent: alertDialogContent),
                      ));
            },
            child: Text(
              text,
              style: TextStyles.semiBold20(context)
                  .copyWith(color: AppColors.thirdColor),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.alertDialogContent,
  });

  final Widget alertDialogContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
          top: context.width * .50,
          left: 5.0,
          right: 5.0,
          bottom: 10.0),
      height: (context.height * .50) - 15.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                child: Icon(
                  CupertinoIcons.xmark,
                  color: AppColors.black,
                  size: getResponsiveFontSize(context: context, fontSize: 37),
                ),
              ),
            ),
          ),
          Spacer(),
          alertDialogContent,
          Spacer(),
        ],
      ),
    );
  }
}
