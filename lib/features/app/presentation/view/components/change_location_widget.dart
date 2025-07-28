import 'package:flutter/material.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';

class ChangeLocationWidget extends StatelessWidget {
  const ChangeLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color dataColor = ThemeCubit.controller(context).state ? Colors.grey: Colors.black;
    return CircleAvatar(
      backgroundColor: Colors.black.withValues(alpha: .3),
      radius: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_pin,
            color: dataColor,
            size: 35,
          ),
          Text(
            "Egypt, Cairo, NewCairo",
            textAlign: TextAlign.center,
            style: TextStyles.semiBold16_120(context)
                .copyWith(color: dataColor),
          )
        ],
      ),
    );
  }
}