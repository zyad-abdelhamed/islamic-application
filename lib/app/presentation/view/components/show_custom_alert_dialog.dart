import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class ShowCustomAlertDialog extends StatelessWidget {
  final String text;
  final Widget alertDialogContent;
  const ShowCustomAlertDialog({
    super.key, required this.text, required this.alertDialogContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5.0,
            backgroundColor: AppColors.primaryColor,
          ),
          TextButton(
            onPressed: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => Center(
                        child: Stack(
                          children: [
                            Container(
                              color: AppColors.primaryColor,
                              margin: EdgeInsets.all(15),
                              height: context.height * 3 / 4 + 1 / 8,
                              width: context.width * 3 / 4,
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.width * 1 / 16,
                                  vertical: context.height * 1 / 4),
                              child: alertDialogContent,
                            ),
                            Positioned(
                                top: 0.0,
                                right: 0.0,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.xmark,
                                      color: AppColors.black,
                                      size: 30,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ));
            },
            child: Text(
              text,
              style: TextStyles.semiBold20(context).copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColors.thirdColor),
            ),
          ),
        ],
      ),
    );
  }
}
