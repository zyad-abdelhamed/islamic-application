import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

class RamadanTableColumn extends StatelessWidget {
  final String title;
  final List listOfStrings;
  final int count;
  final double width;
  const RamadanTableColumn({
    super.key,
    required this.title,
    required this.listOfStrings,
    required this.count,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.grey1)),
              child: Center(child: Text(title))),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: List.generate(
              count,
              (index) => Container(
                  height: double.infinity,
                  width: width,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(border: Border.all(color: AppColors.grey1)),
                  child: FittedBox(child: Text(listOfStrings[index]))),
            ),
          ),
        )
      ],
    );
  }
}
