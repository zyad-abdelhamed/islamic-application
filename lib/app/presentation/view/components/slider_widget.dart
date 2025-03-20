import 'package:flutter/cupertino.dart';
import 'package:test_app/core/theme/app_colors.dart';

class SliderWidget extends StatelessWidget {
  final Widget scrollableWidget;
  final double topPaddingValue;
  final bool visible;
  const SliderWidget(
      {super.key,
      required this.scrollableWidget,
      required this.topPaddingValue,
      required this.visible});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 1.0, top: 1.0, right: 10.0, bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0,
        children: [
          Expanded(child: scrollableWidget),
          Visibility(
            visible: visible,
            maintainSize: true,//to balance left padding with right padding
            maintainAnimation: true,
            maintainState: true,
            child: Container(
              width: 5,
              height: 20,
              margin: EdgeInsets.only(top: topPaddingValue),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: AppColors.black.withValues(alpha: .3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
