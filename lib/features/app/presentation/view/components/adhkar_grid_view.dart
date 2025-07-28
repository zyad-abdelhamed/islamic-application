import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_button.dart';

class AdhkarGridView extends StatefulWidget {
  const AdhkarGridView({super.key, required this.crossAxisCount});

  final int crossAxisCount;

  @override
  State<AdhkarGridView> createState() => _AdhkarGridViewState();
}

class _AdhkarGridViewState extends State<AdhkarGridView> {

  @override
  Widget build(BuildContext context) {
    return GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        children: List<AdhkarButton>.generate(
            8,
            (index) => AdhkarButton(
                text: AppStrings.adhkarButtonsNames[index],
                icon: AppStrings.supplicationIcons[index],
                index: index,
    )));
  }
}
