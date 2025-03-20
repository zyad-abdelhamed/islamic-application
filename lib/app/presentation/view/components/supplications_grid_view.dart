import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/supplications_button.dart';
import 'package:test_app/app/presentation/view/pages/supplications_page.dart';

class SupplicationsGridView extends StatelessWidget {
  const SupplicationsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SupplicationsButton(
          icon: Icons.sunny,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Morning(),));
          },
          text: 'أذكار الصباح',
        ),
        SupplicationsButton(
          icon: Icons.nightlight,
          onTap: () {
            Navigator.pushNamed(context, 'night');
          },
          text: 'أذكار المساء',
        ),
        SupplicationsButton(
          icon: Icons.bed_outlined,
          onTap: () {
            Navigator.pushNamed(context, 'sleep');
          },
          text: 'أذكار النوم',
        ),
        SupplicationsButton(
          icon: Icons.mosque,
          onTap: () {
            Navigator.pushNamed(context, 'mosqe');
          },
          text: 'أذكار المسجد',
        ),
        SupplicationsButton(
          icon: Icons.coffee,
          onTap: () {
            Navigator.pushNamed(context, 'wakeup');
          },
          text: 'أذكار الاستيقاظ',
        ),
        SupplicationsButton(
          icon: Icons.menu_book,
          onTap: () {
            Navigator.pushNamed(context, 'khtm');
          },
          text: 'ختم القران',
        )
      ],
    );
  }
}
