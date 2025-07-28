import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

class ExplainFeatureButton extends StatelessWidget {
  const ExplainFeatureButton({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline, color: Colors.white),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
    Row(
      children: const [
        Icon(Icons.info_outline, color: AppColors.primaryColor),
        SizedBox(width: 10),
        Text(
          'شرح الميزة',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    ),
    const SizedBox(height: 15),
     Text(
      text,
      style: TextStyle(fontSize: 16, height: 1.5),
    ),
    const SizedBox(height: 10),
    Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: const Text('تم', style: TextStyle(color: AppColors.primaryColor)),
        onPressed: () => Navigator.pop(context),
      ),
    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
