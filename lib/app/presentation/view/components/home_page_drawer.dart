import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/app/presentation/view/components/show_custom_alert_dialog.dart';
import 'package:test_app/app/presentation/view/components/custom_switch.dart';
import 'package:test_app/app/presentation/view/components/draw_circle_bloc_builder.dart';
import 'package:test_app/core/theme/cubit/theme_cubit.dart';
import 'package:test_app/core/utils/sized_boxs.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(double.infinity),
              bottomLeft: Radius.circular(double.infinity))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ShowCustomAlertDialog(text: 'التسابيح بعدالصلاة', alertDialogContent: DrawCircleBlocBuilder(),),
          Spacer(),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CustomSwitch(title: 'الوضع الداكن',mainAxisAlignment: MainAxisAlignment.start,onChanged: (bool value) {
              Provider.of<ThemeCubit>(context,listen: false).changeTheme();
            }, value: false,),
          ),
          SizedBoxs.sizedBoxH30
        ],
      ),
    );
  }
}