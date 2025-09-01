import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';

const double circleSize = 80.0;

class DailyAdhkarCard extends StatelessWidget {
  const DailyAdhkarCard({
    super.key,
    required this.dailyAdhkarEntity,
    required this.index,
    required this.onTap,
  });

  final DailyAdhkarEntity dailyAdhkarEntity;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 3.0,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: circleSize,
            width: circleSize,
            padding:
                const EdgeInsets.all(5.0), // Padding بين الصورة والـ border
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: dailyAdhkarEntity.isShowed
                      ? AppColors.grey2
                      : Theme.of(context).primaryColor,
                  width: 5.0),
            ),
            child: ClipOval(
              child: dailyAdhkarEntity.image != null
                  ? Image.memory(
                      dailyAdhkarEntity.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : const ColoredBox(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          width: circleSize + 10,
          child: Text(
            dailyAdhkarEntity.text ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
