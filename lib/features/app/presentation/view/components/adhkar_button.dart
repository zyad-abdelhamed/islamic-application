import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
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
  late double buttonScale;

  @override
  void initState() {
    buttonScale = 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          buttonScale = .9;
        });
        sl<GetAdhkarController>().getAdhkar(AdhkarParameters(
            nameOfAdhkar: widget.text,
            context: context));
      },
      child: AnimatedScale(
        duration: Duration.zero,
        scale: buttonScale,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: ThemeCubit.controller(context).state ? AppColors.darkModeInActiveColor : AppColors.lightModeInActiveColor, borderRadius: BorderRadius.circular(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Theme.of(context).primaryColor,
                size: getResponsiveFontSize(context: context, fontSize: 60),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyles.semiBold18(context, Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
