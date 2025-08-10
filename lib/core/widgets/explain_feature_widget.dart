import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';

class ExplainFeatureButton extends StatelessWidget {
  const ExplainFeatureButton({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    Color dataColor = ThemeCubit.controller(context).state ? AppColors.darkModeTextColor : AppColors.lightModeInActiveColor;
    return IconButton(
      icon: Icon(Icons.help_outline, color: Theme.of(context).primaryColor  ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
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
                  children: [
                    Icon(Icons.info_outline,
                        color: dataColor),
                    SizedBox(width: 10),
                    Text(
                      'شرح الميزة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dataColor,
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
                    child: Text('تم',
                        style:
                            TextStyle(color: dataColor)),
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
