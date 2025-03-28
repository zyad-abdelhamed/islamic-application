import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class FeatuerdRecordsWidget extends StatelessWidget {
  const FeatuerdRecordsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .40,
      height: (context.width * .40) * 1.5,
      margin: const EdgeInsets.only(bottom: 35.0),
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.only(top: 7, left: context.width * .10, right: context.width * .10, bottom: 10),
            child: Divider(
              thickness: 5,
              color: Colors.grey,
            ),
          ),
          Center(
            child: Text(
              'الريكوردات المميزه',
            ),
          ),
          TextButton(
              onPressed: () {},
              child:
                  Text('حذف الكل', style: TextStyles.regular14_150(context).copyWith(color: AppColors.thirdColor))),

          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.5,
                );
              },
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Text(
                  '1000',
                  textAlign: TextAlign.center,
                  style: TextStyles.bold20(context),
                );
              },
            ),
          ),
          // )
        ],
      ),
    );
  }
}
