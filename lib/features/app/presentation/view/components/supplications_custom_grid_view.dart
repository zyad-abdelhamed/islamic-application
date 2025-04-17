import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/components/supplications_button.dart';
import 'package:test_app/features/app/presentation/view/pages/supplications_page.dart';
import 'package:test_app/core/constants/view_constants.dart';

class SupplicationsCustomGridView extends StatelessWidget {
  const SupplicationsCustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List<SupplicationsButton>.generate(
            8,
            (index) => SupplicationsButton(
                  icon:ViewConstants.supplicationIcons[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupplicationsPage(
                              nameOfAdhkar: ViewConstants
                                  .supplicationsButtonsNames[index]),
                        ));
                  },
                  text: ViewConstants.supplicationsButtonsNames[index],
                  horizontalSpacing: _gethorizontalSpacing(index),
                ))
        //  [
        //   SupplicationsButton(
        //     icon: Icons.sunny,
        //     onTap: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => SupplicationsPage(),));
        //     },
        //     text: 'أذكار الصباح',
        //   ),
        //   SupplicationsButton(
        //     icon: Icons.nightlight,
        //     onTap: () {
        //       Navigator.pushNamed(context, 'night');
        //     },
        //     text: 'أذكار المساء',
        //   ),
        //   SupplicationsButton(
        //     icon: Icons.bed_outlined,
        //     onTap: () {
        //       Navigator.pushNamed(context, 'sleep');
        //     },
        //     text: 'أذكار النوم',
        //   ),
        //   SupplicationsButton(
        //     icon: Icons.mosque,
        //     onTap: () {
        //       Navigator.pushNamed(context, 'mosqe');
        //     },
        //     text: 'أذكار المسجد',
        //   ),
        //   SupplicationsButton(
        //     icon: Icons.coffee,
        //     onTap: () {
        //       Navigator.pushNamed(context, 'wakeup');
        //     },
        //     text: 'أذكار الاستيقاظ',
        //   ),
        //   SupplicationsButton(
        //     icon: Icons.menu_book,
        //     onTap: () {
        //       Navigator.pushNamed(context, 'khtm');
        //     },
        //     text: 'ختم القران',
        //   )
        // ],
        );
  }

  double _gethorizontalSpacing(int index) => index % 2 == 0 ? 20 : 0;
}
