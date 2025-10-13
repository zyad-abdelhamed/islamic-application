import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class ReciterCheckTile extends StatelessWidget {
  final ReciterEntity reciter;
  final bool isSelected;
  final Function(bool?) onChanged;

  const ReciterCheckTile({
    super.key,
    required this.reciter,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final imageRadius = context.width * 0.07;

    return Row(
      children: [
        CircleAvatar(
          radius: imageRadius,
          backgroundImage: AssetImage(reciter.image),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reciter.name,
              ),
              Text(
                reciter.language,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Checkbox.adaptive(
          value: isSelected,
          activeColor: AppColors.primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
