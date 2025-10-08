import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/custom_alert_dialog.dart';

class OtherPageButton extends StatelessWidget {
  const OtherPageButton({
    super.key,
    required this.text,
    required this.alertDialogContent,
    required this.logo,
    required this.size,
  });

  final String text;
  final Widget alertDialogContent;
  final String logo;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => CustomAlertDialog(
            title: text,
            alertDialogContent: (_) => alertDialogContent,
            iconWidget: (_) => _logoWidget(AppColors.secondryColor),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الكونتينر الخاص باللوجو
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12), // رديس خفيف
            ),
            padding: const EdgeInsets.all(8),
            child: Center(child: _logoWidget(Colors.white)),
          ),
          const SizedBox(height: 6),
          // النص تحت الكونتينر
          Text(
            text,
            style: TextStyles.semiBold16_120(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Image _logoWidget(Color color) {
    final double size = 40;
    return Image.asset(logo, color: color, height: size, width: size);
  }
}
