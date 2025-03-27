import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/view/pages/rtabel_page.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';

class HomePageButtonsRow extends StatelessWidget {
  const HomePageButtonsRow({super.key});
  final int buttonsCount = 3;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 1 / 8, //same hight of button
      child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: List.generate(
              buttonsCount,
              (index) => _materialButton(
                  context: context,
                  leftMargine: index != buttonsCount - 1
                      ? 16.0
                      : 0.0))), //(leftMargine)spacing between buttons
    );
  }
}

_materialButton(
        {required BuildContext context, required double leftMargine}) =>
    GestureDetector(
      onTap: () {
        
        context.read<TimerCubit>().stopTimer();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RamadanTabelPage(),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(left: leftMargine),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppColors.primaryColor,
        ),
        height: context.height * 1 / 8,
        width: (context.width * 1 / 2) - 8 - 8,
        child: SizedBox(
          height: context.height * 1 / 8,
          width: (context.width * 1 / 2) - 8 - 8,
          child: Row(
            spacing: 10.0,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'السبحه\n الالكترونيه',
                style:
                    TextStyles.bold20(context).copyWith(color: AppColors.white),
              ),
              Icon(
                CupertinoIcons.table,
                color: AppColors.white,
                size: 60,
              )
            ],
          ),
        ),
      ),
    );
