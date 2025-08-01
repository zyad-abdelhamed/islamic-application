import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

GestureDetector onBoardingButton(
    {required BuildContext context,
    required String name,
    required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: const EdgeInsets.only(left: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        name,
        style: TextStyles.bold20(context).copyWith(color: Colors.white),
      ),
    ),
  );
}
