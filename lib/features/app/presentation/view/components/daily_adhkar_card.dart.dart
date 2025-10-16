import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/is_dark.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';

class DailyAdhkarCard extends StatelessWidget {
  const DailyAdhkarCard({
    super.key,
    required this.dailyAdhkarEntity,
    required this.index,
    this.height = 100,
    this.width = 80,
    required this.onTap,
    required this.onLongPress,
  });

  final DailyAdhkarEntity dailyAdhkarEntity;
  final int index;
  final double height, width;
  final void Function() onTap;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color:
                isDark(context) ? Colors.grey.shade800 : Colors.grey.shade300,
            image: dailyAdhkarEntity.image != null
                ? DecorationImage(
                    image: MemoryImage(dailyAdhkarEntity.image!),
                    fit: BoxFit.cover,
                  )
                : null,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: dailyAdhkarEntity.isShowed
                    ? AppColors.grey2
                    : Theme.of(context).primaryColor,
                width: 3.0),
          ),
          child: Text(
            dailyAdhkarEntity.text ?? '',
            softWrap: true,
            maxLines: 50,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )),
    );
  }
}
