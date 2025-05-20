import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/adhkar_cubit.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

AppBar adhkarPageAppBar(BuildContext context, {required String appBarTitle}) {
  return AppBar(
    title: FittedBox(fit: BoxFit.scaleDown, child: Text(appBarTitle)),
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'الحذف بعد الانتهاء',
              style: TextStyles.bold20(context),
            ),
            const SizedBox(width: 12),
            BlocBuilder<AdhkarCubit, AdhkarState>(
              buildWhen: (previous, current) =>
                  previous.isDeleted != current.isDeleted,
              builder: (context, state) {
                print('rebuild adhkar page switch');
                return Switch.adaptive(
                  activeColor: AppColors.thirdColor,
                  activeTrackColor: AppColors.thirdColor.withValues(alpha: 0.8),
                  inactiveThumbColor: AppColors.black,
                  inactiveTrackColor: AppColors.inActiveBlackColor,
                  value: state.isDeleted,
                  onChanged: (bool value) {
                    context.supplicationsController.toggleIsDeletedSwitch();
                  },
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
