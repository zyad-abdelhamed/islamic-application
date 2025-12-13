import 'package:flutter/material.dart';
import 'package:test_app/core/theme/theme_controller.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';

class ToggleThemeTemporarilyButton extends StatelessWidget {
  const ToggleThemeTemporarilyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ThemeCubit.controller(context).toggleThemeWithoutSaveState,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: context.isDarkMode ? Colors.yellow[600] : Colors.grey[850],
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 3),
              color: Colors.black.withAlpha(50),
            )
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, anim) =>
              ScaleTransition(scale: anim, child: child),
          child: Icon(
            context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            key: ValueKey(!context.isDarkMode),
            size: 24,
            color: context.isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
