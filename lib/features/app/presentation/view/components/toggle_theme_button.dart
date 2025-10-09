import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "إعدادات المظهر",
              style: TextStyles.bold20(context),
            ),
            const SizedBox(height: 16),
            RadioButton(title: "الوضع الفاتح", themeMode: ThemeMode.light),
            RadioButton(title: "الوضع الداكن", themeMode: ThemeMode.dark),
            RadioButton(
                title: "الوضع التلقائي (حسب النظام)",
                themeMode: ThemeMode.system),
          ],
        ),
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.title,
    required this.themeMode,
  });

  final String title;
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = ThemeCubit.controller(context);

    return RadioListTile<ThemeMode>(
      activeColor: AppColors.primaryColor,
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      value: themeMode,
      groupValue: context.watch<ThemeCubit>().state,
      onChanged: (val) => themeCubit.toggleTheme(themeMode),
    );
  }
}
