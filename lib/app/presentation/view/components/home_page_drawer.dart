import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/alert_dialog_widget.dart';
import 'package:test_app/app/presentation/view/components/custom_switch.dart';
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
        children: [
          ShowAlertDialogWidget(),
          Spacer(),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CustomSwitch(title: 'الوضع الداكن',mainAxisAlignment: MainAxisAlignment.start,onChanged: (bool value) {
              
            }, value: true,),
          ),
          SizedBoxs.sizedBoxH30
        ],
      ),
    );
  }
}