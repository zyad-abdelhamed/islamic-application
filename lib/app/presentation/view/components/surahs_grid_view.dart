import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class SurahsGridView extends StatelessWidget {
  const SurahsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5
            ),
        itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondryColor),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'اسم السورة\nعدد الأيات\nمكيه',
                  textAlign: TextAlign.center,
                  style: TextStyles.semiBold16(context: context, color: AppColors.thirdColor),
                ),
              ),    
            ));
  }
}