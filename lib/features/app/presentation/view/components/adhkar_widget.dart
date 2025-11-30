import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_text_view.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget_controls.dart';

class AdhkarWidget extends StatelessWidget {
  const AdhkarWidget(
      {super.key,
      required this.index,
      required this.adhkarEntity,
      required this.adhkarPageController});

  final int index;
  final AdhkarEntity adhkarEntity;
  final AdhkarPageController adhkarPageController;

  @override
  Widget build(BuildContext context) {
    const double spacing = 10.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: spacing),
        AdhkarWidgetControls(
          adhkarEntity: adhkarEntity,
          adhkarPageController: adhkarPageController,
          index: index,
        ),
        const SizedBox(height: spacing + 10.0),
        AdhkarTextView(
          content: adhkarEntity.content,
          desc: adhkarEntity.description,
          fontSizeNotfier: adhkarPageController.fontSizeNotfier,
          spacing: spacing,
        ),
        const SizedBox(height: spacing),
      ],
    );
  }
}
