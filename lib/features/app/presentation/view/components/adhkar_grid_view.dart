import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_button.dart';

class AdhkarGridView extends StatelessWidget {
  const AdhkarGridView({
    super.key,
    required this.crossAxisCount,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  final int crossAxisCount;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    List names = AppStrings.translate("adhkarButtonsNames");
    List images = AppStrings.translate("adhkarButtonsPhotos");

    return GridView(
      shrinkWrap: true,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      children: List<AdhkarButton>.generate(
        8,
        (index) => AdhkarButton(
          index: index,
          imagePath: images[index],
          icon: _supplicationIcons[index],
          text: names[index],
        ),
      ),
    );
  }
}

const List<IconData> _supplicationIcons = <IconData>[
  Icons.wb_sunny, // أذكار الصباح
  Icons.nightlight_round, // أذكار المساء
  Icons.check_circle_outline, // أذكار بعد السلام من الصلاة المفروضة
  Icons.spa, // تسابيح
  Icons.bedtime, // أذكار النوم
  Icons.alarm, // أذكار الاستيقاظ
  Icons.book, // أدعية قرآنية
  Icons.group, // أدعية الأنبياء
];
