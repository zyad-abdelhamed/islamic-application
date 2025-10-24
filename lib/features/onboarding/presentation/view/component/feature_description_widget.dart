import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class FeatureDescriptionWidget extends StatelessWidget {
  const FeatureDescriptionWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.imageColor,
  });

  final String image, title, description;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 90,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 90,
          child: Image.asset(
            image,
            color: imageColor,
            fit: BoxFit.fill,
          ),
        ),
        Text(
          title,
          style: TextStyles.semiBold32Decoreted(
            context,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyles.semiBold16(
            context: context,
            color: AppColors.secondryColor,
          ),
        ),
      ],
    );
  }
}
