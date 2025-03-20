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
      width:context.width * .40,
      height:(context.width * .40) * 1.5,
      margin: const EdgeInsets.only(bottom: 35.0),
      decoration: BoxDecoration(
          color:// Colors.grey[50],
          AppColors.secondryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13)),
          boxShadow: const [
            BoxShadow(
                blurRadius: 2,
                offset: Offset(5,5),
                color: AppColors.grey2
                )
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
                top: 7, left: 55, right: 55, bottom: 10),
            child: Divider(
              thickness: 5,
              color: Colors.grey,
            ),
          ),
          Center(
            child:  Text(
              'الريكوردات المميزه',
              style: TextStyles.semiBold18(context, AppColors.purple),
            ),
          ),
          TextButton(onPressed: () {
            
          }, child: Text('حذف الكل',style: TextStyles.regular16_120(context, color: AppColors.white))),
          
           Expanded(
          //   child: FutureBuilder(
          //     future: controller.init(),
          //     builder: (context, snapshot) =>
                child:  ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  );
                },
                physics: const BouncingScrollPhysics(),
                itemCount:10,// snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Text(
                                   //   snapshot.data?[index].number.toString() ??
                        '1000',
                    textAlign: TextAlign.center,style: TextStyles.semiBold18(context,AppColors.purple),
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
