import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_adhkar_controller.dart';

class AdhkarButton extends StatefulWidget {
  const AdhkarButton({
    super.key,
    required this.icon,
    required this.text,
  });

  final String text;
  final IconData icon;

  @override
  State<AdhkarButton> createState() => _AdhkarButtonState();
}

class _AdhkarButtonState extends State<AdhkarButton> {
  late final ValueNotifier<double> scaleNoitfier;

  @override
  void initState() {
    super.initState();
    scaleNoitfier = ValueNotifier<double>(1.0);
  }

  @override
  void dispose() {
    scaleNoitfier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        scaleNoitfier.value = .9;
        sl<GetAdhkarController>().getAdhkar(
            AdhkarParameters(nameOfAdhkar: widget.text, context: context));
      },
      child: ValueListenableBuilder(
          valueListenable: scaleNoitfier,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primaryColorInActiveColor,
                borderRadius: BorderRadius.circular(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: Theme.of(context).primaryColor,
                  size: getResponsiveFontSize(context: context, fontSize: 60),
                ),
                Text(
                  widget.text,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyles.semiBold18(
                      context, Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
          builder: (BuildContext context, double value, Widget? child) {
            return AnimatedScale(
              duration: Duration.zero,
              scale: value,
              child: child,
            );
          }),
    );
  }
}
