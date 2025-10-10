import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
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

    return Card(
      color: AppColors.primaryColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          radius: imageRadius,
          backgroundImage: AssetImage(reciter.image),
        ),
        title: Text(
          reciter.name,
          style: TextStyles.semiBold18(context, AppColors.darkModeTextColor),
        ),
        subtitle: Text(
          reciter.language,
          style: TextStyles.regular14_150(
            context,
          ).copyWith(color: AppColors.lightModeScaffoldBackGroundColor),
        ),
        trailing: Checkbox(
          value: isSelected,
          activeColor: Colors.white,
          checkColor: AppColors.primaryColor,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
