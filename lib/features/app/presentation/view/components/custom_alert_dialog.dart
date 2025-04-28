import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.alertDialogContent,
  });

  final WidgetBuilder alertDialogContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
              height: double.infinity,
              width: 400,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(35)),
              child: Stack(
                  children: [

                    Center(child: alertDialogContent(context)),
                    Positioned(top: 0.0,right: 0.0,
                      child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: AppColors.black,
                      size:
                          getResponsiveFontSize(context: context, fontSize: 37),
                    ),
                  ),
                ))
                  ],
                ),
              ),
           
          ),
        ],
      ),
    );
  }
}
