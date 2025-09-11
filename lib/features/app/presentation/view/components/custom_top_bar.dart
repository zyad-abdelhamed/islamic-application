import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class CustomTopBar extends StatelessWidget {
  const CustomTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height * 0.1,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: AppColors.lightModePrimaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
    );
  }
}
