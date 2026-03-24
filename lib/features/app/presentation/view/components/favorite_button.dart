import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';

class FavoriteButton<C extends StateStreamable<S>, S> extends StatefulWidget {
  final bool initialFavorite;
  final void Function(bool isFavorite)? toggleFavorite;

  final void Function(
    BuildContext ctx,
    S state,
    VoidCallback runAnimation,
  ) listener;

  const FavoriteButton({
    super.key,
    required this.initialFavorite,
    this.toggleFavorite,
    required this.listener,
  });

  @override
  State<FavoriteButton<C, S>> createState() => _FavoriteButtonState<C, S>();
}

class _FavoriteButtonState<C extends StateStreamable<S>, S>
    extends State<FavoriteButton<C, S>> with SingleTickerProviderStateMixin {
  late bool isFavorite;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.2,
    );

    _scaleAnimation = _controller.drive(
      Tween(begin: 1.0, end: 1.2),
    );
  }

  void runAnimation() {
    setState(() {
      isFavorite = !isFavorite;
    });

    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  void didUpdateWidget(covariant FavoriteButton<C, S> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialFavorite != widget.initialFavorite) {
      isFavorite = widget.initialFavorite;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, S>(
      listener: (context, state) =>
          widget.listener(context, state, runAnimation),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: InkWell(
          onTap: () => widget.toggleFavorite?.call(isFavorite),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isFavorite
                  ? const LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isFavorite ? null : AppColors.grey1,
              boxShadow: isFavorite
                  ? [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.white : AppColors.primaryColor,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
