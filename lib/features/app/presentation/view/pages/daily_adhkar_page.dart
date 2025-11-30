import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
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
    final DailyAdhkarEntity entity = widget.entities[widget.index];

    return WillPopScope(
      onWillPop: () async {
        controller.back();
        return false;
      },
      child: CustomScaffold(
        backgroundColor: Colors.black,
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
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              controller.back();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              // الخلفية (صورة أو لون)
              Positioned.fill(
                child: entity.image != null
                    ? Image.memory(entity.image!)
                    : Container(color: Theme.of(context).primaryColor),
              ),
              // النص
              Center(
                child: AutoSizeText(
                  entity.text ?? '',
                  textAlign: TextAlign.center,
                  style:
                      TextStyles.bold20(context).copyWith(color: Colors.white),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: controller.isPausedByUser,
                child: // شريط التقدّم
                    Positioned(
                  top: 8,
                  right: 8,
                  left: 8,
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
                              Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                builder: (_, bool paused, Widget? child) {
                  if (!paused) return child!;
                  return const Positioned.fill(child: IgnorePointer());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
