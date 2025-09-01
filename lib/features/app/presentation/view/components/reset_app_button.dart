import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/controllers/settings_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/reset_app_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';

class ResetAppButton extends StatelessWidget {
  const ResetAppButton({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDeleteAlertDialog(context,
              deleteFunction: context.read<ResetAppCubit>().resetApp,
              content: Text(AppStrings.translate("resetAppWarning")));
        },
        child: Text(
          AppStrings.translate("deleteAllData"),
          style: TextStyle(color: AppColors.errorColor),
        ));
  }
}
