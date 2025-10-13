import 'package:flutter/material.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_text_view.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget_controls.dart';

class AdhkarWidget extends StatefulWidget {
  const AdhkarWidget(
      {super.key,
      required this.index,
      required this.adhkarEntity,
      required this.adhkarPageController});

  final int index;
  final AdhkarEntity adhkarEntity;
  final AdhkarPageController adhkarPageController;

  @override
  State<AdhkarWidget> createState() => _AdhkarWidgetState();
}

class _AdhkarWidgetState extends State<AdhkarWidget> {
  @override
  Widget build(BuildContext context) {
    final String content = widget.adhkarEntity.content;
    final String? desc = widget.adhkarEntity.description;
    final ValueNotifier<double> fontSizeNotfier =
        widget.adhkarPageController.fontSizeNotfier;
    final ValueNotifier<NumberAnimationModel> countNotifier =
        widget.adhkarEntity.countNotifier;

    return Column(
      spacing: 15,
      children: [
        AdhkarWidgetControls(
          content: content,
          desc: desc,
          countNotifier: countNotifier,
          decreaseCount: () => widget.adhkarPageController.decreaseCount(
              countPrameters: CountPrameters(
            index: widget.index,
            countNotifier: countNotifier,
            adhkarEntity: widget.adhkarEntity,
          )),
          resetCount: () => widget.adhkarPageController.resetCount(
              countPrameters: CountPrameters(
            index: widget.index,
            countNotifier: countNotifier,
            adhkarEntity: widget.adhkarEntity,
          )),
        ),
        AdhkarTextView(
          content: content,
          desc: desc,
          fontSizeNotfier: fontSizeNotfier,
        ),
      ],
    );
  }
}
