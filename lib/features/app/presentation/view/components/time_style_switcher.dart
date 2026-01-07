import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/cubit/time_style_cubit.dart';

class TimeStyleSwitcher extends StatelessWidget {
  const TimeStyleSwitcher({super.key, required this.currentStyle});

  final TimeNumberStyle currentStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TimeNumberStyle>(
      icon: const Icon(Icons.style, color: Colors.grey),
      onSelected: context.read<TimeStyleCubit>().changeStyle,
      itemBuilder: (_) => [
        _buildItem(
          context,
          value: TimeNumberStyle.fingerPaint,
          title: 'أرقام مرسومة',
          subtitle: 'الأسلوب المرشّح من التطبيق',
          currentStyle: currentStyle,
        ),
        _buildItem(
          context,
          value: TimeNumberStyle.sevenSegment,
          title: 'أرقام رقمية',
          currentStyle: currentStyle,
        ),
        _buildItem(
          context,
          value: TimeNumberStyle.normal,
          title: 'أرقام عادية',
          currentStyle: currentStyle,
        ),
      ],
    );
  }

  PopupMenuItem<TimeNumberStyle> _buildItem(
    BuildContext context, {
    required TimeNumberStyle value,
    required String title,
    String? subtitle,
    required TimeNumberStyle currentStyle,
  }) {
    final isSelected = value == currentStyle;

    return PopupMenuItem<TimeNumberStyle>(
      value: value,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check_circle,
              color: AppColors.primaryColor,
              size: 20,
            ),
        ],
      ),
    );
  }
}
