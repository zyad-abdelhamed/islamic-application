import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/helper_function/is_dark.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/speech_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plans_widget.dart';
import 'package:test_app/features/app/presentation/view/pages/speech_page.dart';

class QuranHifzPage extends StatefulWidget {
  const QuranHifzPage({super.key});

  @override
  State<QuranHifzPage> createState() => _QuranHifzPageState();
}

class _QuranHifzPageState extends State<QuranHifzPage> {
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("تحفيظ القرآن"),
          leading: const GetAdaptiveBackButtonWidget(
              backBehavior: BackBehavior.pop)),
      body: const QuranMemorizationPlansWidget(),
      // bottomNavigationBar: ValueListenableBuilder<int>(
      //   valueListenable: currentIndex,
      //   builder: (context, index, _) {
      //     final double horizontalMargin = context.width * 0.2;

      //     return Container(
      //       margin: EdgeInsets.symmetric(
      //           horizontal: horizontalMargin, vertical: 8.0),
      //       padding: const EdgeInsets.all(8.0),
      //       decoration: BoxDecoration(
      //         color: Theme.of(context).cardColor,
      //         borderRadius:
      //             BorderRadius.circular(ConstantsValues.fullCircularRadius),
      //         boxShadow: [
      //           BoxShadow(
      //             color: isDark(context)
      //                 ? Colors.black.withAlpha((0.45 * 255).toInt())
      //                 : Colors.black.withAlpha((0.08 * 255).toInt()),
      //             blurRadius: isDark(context) ? 14 : 8,
      //             offset: const Offset(0, 6),
      //           ),
      //         ],
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           // Item 0
      //           _NavItem(
      //             icon: Icons.mic,
      //             label: 'تسميع',
      //             isActive: index == 0,
      //             onTap: () {
      //               currentIndex.value = 0;
      //               pageController.jumpToPage(0);
      //             },
      //           ),

      //           // Item 1
      //           _NavItem(
      //             icon: Icons.calendar_month,
      //             label: 'الخطط',
      //             isActive: index == 1,
      //             onTap: () {
      //               currentIndex.value = 1;
      //               pageController.jumpToPage(1);
      //             },
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color fg = isActive ? AppColors.primaryColor : Colors.grey;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        spacing: 5.0,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: fg),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
