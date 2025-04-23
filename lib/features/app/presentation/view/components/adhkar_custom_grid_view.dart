import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_button.dart';
import 'package:test_app/features/app/presentation/view/pages/adhkar_page.dart';
import 'package:test_app/core/constants/view_constants.dart';

class AdhkarCustomGridView extends StatelessWidget {
  const AdhkarCustomGridView({super.key, required this.crossAxisCount});
  final int crossAxisCount;
  @override
  Widget build(BuildContext context) {
    const double spacing = 15;
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing),
        children: List<AdhkarButton>.generate(
            8,
            (index) => AdhkarButton(
                  icon: ViewConstants.supplicationIcons[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdhkarPage(
                              nameOfAdhkar: ViewConstants
                                  .supplicationsButtonsNames[index]),
                        ));
                  },
                  text: ViewConstants.supplicationsButtonsNames[index],
                )));
  }
}
