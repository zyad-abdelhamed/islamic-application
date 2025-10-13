import 'package:flutter/cupertino.dart';
import 'package:test_app/core/theme/app_colors.dart';

class AppLoadingWidget extends StatefulWidget {
  final Color color;
  final Duration speed;

  const AppLoadingWidget({
    super.key,
    this.color = AppColors.successColor,
    this.speed = const Duration(milliseconds: 300),
  });

  @override
  State<AppLoadingWidget> createState() => _AppLoadingWidgetState();
}

class _AppLoadingWidgetState extends State<AppLoadingWidget> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _startLoop();
  }

  void _startLoop() {
    Future.doWhile(() async {
      await Future.delayed(widget.speed);
      if (!mounted) return false;
      setState(() {
        activeIndex = (activeIndex + 1) % 3;
      });
      return true;
    });
  }

  Widget _buildChevron(int index, double size, double offsetY) {
    final isActive = index == activeIndex;
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: AnimatedOpacity(
        duration: widget.speed,
        opacity: isActive ? 1.0 : 0.2,
        child: Icon(
          CupertinoIcons.chevron_down,
          color: widget.color,
          size: size,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 48,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _buildChevron(0, 20, 0),
          _buildChevron(1, 26, 6),
          _buildChevron(2, 32, 12),
        ],
      ),
    );
  }
}
