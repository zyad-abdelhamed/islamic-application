import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class ListTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const ListTileWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: Border(bottom: BorderSide(color: AppColors.grey)),
        title: Row(
          children: <Widget>[
            Icon(icon, color: AppColors.primaryColor),
            Text(title, style: TextStyles.semiBold32auto(context)),
          ],
        ),
        trailing: Icon(
          CupertinoIcons.right_chevron,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
