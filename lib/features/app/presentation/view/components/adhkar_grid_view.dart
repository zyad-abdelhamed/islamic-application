import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_button.dart';
import 'package:test_app/features/app/presentation/view/pages/adhkar_page.dart';

class AdhkarGridView extends StatelessWidget {
  const AdhkarGridView({
    super.key,required this.crossAxisCount
  });
  
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        children: List<AdhkarButton>.generate(
            8,
            (index) => AdhkarButton(
                  icon: AppStrings.supplicationIcons[index],
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdhkarPage(
                              nameOfAdhkar: AppStrings
                                  .adhkarButtonsNames[index]),
                        ));
                  },
                  text: AppStrings.adhkarButtonsNames[index],
                )));
  }
}