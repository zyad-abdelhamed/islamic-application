import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/daily_adhkar_page_controller.dart';

class DailyAdhkarPage extends StatefulWidget {
  const DailyAdhkarPage({
    super.key,
    required this.entities,
    required this.index,
  });

  final List<DailyAdhkarEntity> entities;
  final int index;

  @override
  State<DailyAdhkarPage> createState() => _DailyAdhkarPageState();
}

class _DailyAdhkarPageState extends State<DailyAdhkarPage>
    with SingleTickerProviderStateMixin {
  late DailyAdhkarController controller;

  @override
  void initState() {
    super.initState();
    controller = DailyAdhkarController(
      vsync: this,
      context: context,
      entities: widget.entities,
      index: widget.index,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor =
        isDark ? AppColors.darkModeTextColor : AppColors.lightModeTextColor;
    final DailyAdhkarEntity entity = widget.entities[widget.index];

    return Scaffold(
      body: GestureDetector(
        onLongPress: controller.onLongPress,
        onLongPressEnd: controller.onLongPressEnd,
        onHorizontalDragEnd: (details) {
          // لو السرعة موجبة → من الشمال لليمين
          if (details.primaryVelocity! > 0) {
            controller.toNextPage();
          }
          // لو السرعة سالبة → من اليمين للشمال
          else if (details.primaryVelocity! < 0) {
            controller.toPreviousPage();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // الخلفية (صورة أو لون)
            Positioned.fill(
              child: entity.image != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.memory(
                          entity.image!,
                          fit: BoxFit.cover,
                        ),
                        Container(color: Colors.grey.withAlpha(77)),
                      ],
                    )
                  : Container(color: Theme.of(context).primaryColor),
            ),
            // النص
            Center(
              child: Text(
                entity.text ?? '',
                textAlign: TextAlign.center,
                style: TextStyles.bold20(context).copyWith(color: textColor),
              ),
            ),
            // زر رجوع
            Positioned(
              top: 12,
              right: 12,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: controller.back,
                ),
              ),
            ),
            // شريط التقدّم
            Positioned(
              top: 8,
              right: 60,
              left: 12,
              child: SafeArea(
                child: AnimatedBuilder(
                  animation: controller.controller,
                  builder: (context, _) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: controller.controller.value,
                        minHeight: 4,
                        backgroundColor: Colors.white.withAlpha(64),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // overlay الإيقاف
            ValueListenableBuilder<bool>(
              valueListenable: controller.isPausedByUser,
              builder: (_, paused, __) {
                if (!paused) return const SizedBox.shrink();
                return const Positioned.fill(child: IgnorePointer());
              },
            ),
          ],
        ),
      ),
    );
  }
}
