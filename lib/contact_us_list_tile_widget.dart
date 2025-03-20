import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

Widget contactUsListTileWidget(
    {required IconData icon,
    required String title,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: AppColors.grey, width: .65)),
      title: Row(
        spacing: 5.0,
        children: <Widget>[
          Icon(icon, color: AppColors.primaryColor),
          Text(title, style: TextStyles.semiBold32auto(context)),
        ],
      ),
    ),
  );
}
