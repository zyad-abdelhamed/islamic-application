import 'package:flutter/material.dart';
import 'package:test_app/core/theme/theme_controller.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';

class ToggleThemeTemporarilyButton extends StatelessWidget {
  const ToggleThemeTemporarilyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ThemeCubit.controller(context).toggleThemeWithoutSaveState,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Icon(
          context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(context.isDarkMode),
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
