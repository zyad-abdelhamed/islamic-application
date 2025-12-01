import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? appBar;

  const CustomTopBar({super.key, required this.appBar});

  @override
  Widget build(BuildContext context) {
    if (appBar == null) {
      return const SizedBox.shrink();
    }

    // لو الودجت AppBar → نقرأ خصائصه
    if (appBar is AppBar) {
      final real = appBar as AppBar;

      return SafeArea(
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (real.leading != null) real.leading!,
              if (real.leading != null) const SizedBox(width: 12),
              Expanded(
                child: DefaultTextStyle(
                  style: real.titleTextStyle ??
                      Theme.of(context).textTheme.titleLarge!,
                  child: real.title ?? const SizedBox(),
                ),
              ),
              if (real.actions != null) ...real.actions!,
            ],
          ),
        ),
      );
    }

    // لو الودجت مش AppBar → أعرضه زي ما هو
    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        child: appBar!,
      ),
    );
  }

  @override
  Size get preferredSize {
    if (appBar == null) return Size.zero;

    if (appBar is AppBar) {
      final real = appBar as AppBar;
      return Size(double.infinity, real.preferredSize.height);
    }

    // الحالات اللي الودجت فيها PreferredSizeWidget غير AppBar
    return appBar!.preferredSize;
  }
}
