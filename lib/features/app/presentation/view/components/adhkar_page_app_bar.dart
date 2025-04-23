import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/supplications_cubit.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

AppBar adhkarPageAppBar(BuildContext context,
    {required String appBarTitle}) {
  return AppBar(
      title: Text(
        appBarTitle,
      ),
      bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Row(
              spacing: 10.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'الحذف بعد الانتهاء',
                  style: TextStyles.bold20(context),
                ),
                BlocBuilder<AdhkarCubit, AdhkarState>(
                    buildWhen: (previous, current) =>
                        previous.isDeleted != current.isDeleted,
                    builder: (context, state) {
                      print('rebuild adhkar page switch');

                      return Switch.adaptive(
                        activeColor: AppColors.thirdColor,
                        activeTrackColor:
                            AppColors.thirdColor.withValues(alpha: .8),
                        inactiveThumbColor: AppColors.black,
                        inactiveTrackColor: AppColors.inActiveBlackColor,
                        value: state.isDeleted,
                        onChanged: (bool value) {
                          context.supplicationsController
                              .toggleIsDeletedSwitch();
                        },
                      );
                    })
              ])));
}
