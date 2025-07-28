import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.alertDialogContent,
    required this.title,
  });
  final String title;
  final WidgetBuilder alertDialogContent;

  @override
  Widget build(BuildContext context) {
    const double radius = 37.0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: ThemeCubit.controller(context).state ? AppColors.black : AppColors.white,
              borderRadius: BorderRadius.circular(35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  CupertinoIcons.xmark,
                  size: radius,
                ),
              ),
              Center(
                child: Text(title,
                    style: TextStyles.semiBold32auto(context)
                        .copyWith(color: AppColors.primaryColor)),
              ),
              Divider(),
              Expanded(
                  child: Center(
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.all(8.0),
                          child: alertDialogContent(context)))),
            ],
          ),
        ),
      ),
    );
  }
}
