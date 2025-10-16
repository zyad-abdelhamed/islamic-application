import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/custom_alert_dialog.dart';

class QuranMemorizationPlansWidget extends StatelessWidget {
  const QuranMemorizationPlansWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ListTile(
          onTap: () => _showAddDialog(context),
          title: AppStrings.translate("createNewPlan"),
          leading: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
          trailing: const Icon(Icons.chevron_left),
        ),
      ],
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: AppStrings.translate("createNewPlan"),
        alertDialogContent: (context) => TextField(),
        iconWidget: (context) => const Icon(
          Icons.add,
          color: AppColors.secondryColor,
        ),
      ),
    );
  }
}
