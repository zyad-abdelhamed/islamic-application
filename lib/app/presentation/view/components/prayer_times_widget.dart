import 'package:flutter/cupertino.dart';
import 'package:test_app/app/presentation/view/components/remaining_time_widget.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          margin: EdgeInsets.only(bottom: 10.0),//spacing
          decoration: _boxDecoration(color: AppColors.primaryColor),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: (context.width * .04) - 5),
                child: _getRowOfPrayers(context, textList: prayerTimes),
              ),
              Container(
                height: context.height * .22,
                width: double.infinity,
                decoration: _boxDecoration(
                    color: AppColors.inActivePrimaryColor.withValues(alpha: .3)),
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getRowOfPrayers(context,
                        textList: ViewConstants.namesOfPrayers1),
                    _getRowOfPrayers(context, textList: ViewConstants.emojisOfPrayers),    
                    Text(
                      'الصلاه القادمه :',
                      style: TextStyles.bold20(context).copyWith(
                          color: AppColors.secondryColor,
                          shadows: _shadows,
                          fontSize: 23),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        RemainingTimeWidget(),
      ],
    );
  }

  List<Shadow> get _shadows {
    return <BoxShadow>[
      BoxShadow(
          spreadRadius: 2,
          offset: const Offset(-5.0, -5.0),
          color: AppColors.purple.withValues(alpha: 0.2))
    ];
  }

  Row _getRowOfPrayers(BuildContext context, {required List<String> textList}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Text>.generate(
        6,
        (index) => Text(
          textList[index],
          style: TextStyles.bold20(context).copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

List<String> prayerTimes = ['5:2', '5:2', '5:2', '5:2', '5:2','5,2'];
BoxDecoration _boxDecoration({required Color color}) =>
    BoxDecoration(borderRadius: BorderRadius.circular(35.0), color: color);
