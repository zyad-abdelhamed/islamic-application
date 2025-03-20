import 'package:flutter/cupertino.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(horizontal:  5.0,vertical: 10.0),
      decoration: _boxDecoration(color: AppColors.primaryColor),
      child: Container(height: context.height * .22 ,width: double.infinity,
        decoration: _boxDecoration(color: AppColors.inActivePrimaryColor.withValues(alpha: .3)),
        margin: EdgeInsets.only(top: context.width * .08),
        padding: EdgeInsets.only(bottom:  20.0,right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(),
            Text('الصلاه القادمه :',style: TextStyles.bold20(context).copyWith(color: AppColors.secondryColor,shadows: [
    BoxShadow(
       // blurRadius: 2,
       spreadRadius: 2,
        offset: const Offset(-5.0,-5.0),
        color: AppColors.purple.withValues(alpha: 0.2)
       )
  ],fontSize: 28),)
          ],
        ),
      ),
    );
  }
}

BoxDecoration _boxDecoration({required Color color}) =>
    BoxDecoration(borderRadius: BorderRadius.circular(35.0), color: color);
