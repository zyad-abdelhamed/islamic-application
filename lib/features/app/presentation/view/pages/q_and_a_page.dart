import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class QAndAPage extends StatelessWidget {
  const QAndAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.primaryColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: GetAdaptiveBackButtonWidget(),
                    suffix: TextButton(
                        onPressed: () {},
                        child: Text(
                          "send",
                          style: TextStyles.bold20(context)
                              .copyWith(color: AppColors.primaryColor(context)),
                        )))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
