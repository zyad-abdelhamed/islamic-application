
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

Widget customAppBar({required CustomAppBarInputModel customAppBarInputModel}) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: customAppBarInputModel.iconButtonOnPressedFunction,
          icon: Icon(
            Icons.arrow_circle_left,
            color: AppColors.black,
            size: 30,
          ),
        ),
        Text(
          customAppBarInputModel.appBarTitle,
          style: TextStyles.semiBold32(customAppBarInputModel.context,
              color: AppColors.black),
        ),
      ],
    );

class CustomAppBarInputModel {
  final String appBarTitle;
  final BuildContext context;
  final VoidCallback iconButtonOnPressedFunction;

  CustomAppBarInputModel(
      {required this.appBarTitle,
      required this.context,
      required this.iconButtonOnPressedFunction});
}
