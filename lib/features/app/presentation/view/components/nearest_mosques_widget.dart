import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class NearestMosquesWidget extends StatefulWidget {
  const NearestMosquesWidget({super.key});

  @override
  State<NearestMosquesWidget> createState() => _NearestMosquesWidgetState();
}

class _NearestMosquesWidgetState extends State<NearestMosquesWidget> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Container(
            color: AppColors.grey1,
            width: double.infinity,
          //  height: context.height * .05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: () {
                  setState(() {
                  show = true;
                  });
                }, icon: Icon(CupertinoIcons.chevron_down)),
                Text(
                  'المساجد القريبه',
                  style: TextStyles.bold20(context)
                      .copyWith(color: AppColors.primaryColor, fontSize: 23),
                ),
              ],
            ),
          ),
          Visibility(
            visible: show,
            child: SizedBox(
              height: context.height * .50,
              width: double.infinity,
              child: Container(color: AppColors.primaryColor,height: context.height * .50,
              width: double.infinity,),
            ),
          )
        ],
      ),
    );
  }
}
