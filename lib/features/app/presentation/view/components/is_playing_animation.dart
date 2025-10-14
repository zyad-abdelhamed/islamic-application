import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

class IsPlayingAnimation extends StatefulWidget {
  final int bars = 3;
  final double width = 20;
  final double height = 20;
  final bool isActive;
  final Color activeColor = AppColors.successColor;
  final Color inactiveColor = const Color(0xFF444444);
  final Duration duration = const Duration(milliseconds: 900);

  const IsPlayingAnimation({
    super.key,
    this.isActive = true,
  });

  @override
  State<IsPlayingAnimation> createState() => _IsPlayingAnimationState();
}

class _IsPlayingAnimationState extends State<IsPlayingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;
  late final List<Animation<double>> _heights;
  late final List<Animation<double>> _opacity;

  @override
  void initState() {
    super.initState();

    _ctl = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.isActive) {
      _ctl.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ctl.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _ctl.forward();
        }
      });
      _ctl.forward();
    }

    _heights = List.generate(widget.bars, (i) {
      final start = i * 0.15;
      final end = (start + 0.7).clamp(0.0, 1.0);
      return Tween<double>(
        begin: widget.height * 0.3,
        end: widget.height,
      ).animate(CurvedAnimation(
        parent: _ctl,
        curve: Interval(start, end, curve: Curves.easeInOut),
      ));
    });

    _opacity = List.generate(widget.bars, (i) {
      final start = i * 0.15;
      final end = (start + 0.7).clamp(0.0, 1.0);
      return Tween<double>(
        begin: 0.6,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _ctl,
        curve: Interval(start + 0.05, end, curve: Curves.easeInOut),
      ));
    });
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  Widget _buildBar(int index) {
    return AnimatedBuilder(
      animation: _ctl,
      builder: (context, child) {
        final h = _heights[index].value;
        final op = _opacity[index].value;

        return Opacity(
          opacity: op,
          child: Container(
            width: (widget.width / (widget.bars * 1.7)).clamp(6.0, 18.0),
            height: h,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: widget.activeColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(widget.bars, (i) {
          return Container(
            width: (widget.width / (widget.bars * 1.7)).clamp(6.0, 18.0),
            height: widget.height * 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: widget.inactiveColor,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(widget.bars, (i) => _buildBar(i)),
    );
  }
}
