import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class PortraitOrientationWidgetToRTablePage extends StatelessWidget {
  const PortraitOrientationWidgetToRTablePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 200.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom:  8.0 ,right: 8.0,left: 8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'لإستخدام جدول رمضان يجب تفعيل التوجيه العرضي للموبايل.',
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 216, 189, 105),
                    shadows: [
                      BoxShadow(blurRadius: 2, color: Colors.brown)
                    ]),
              ),
              OutlinedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                onPressed: () {},
                child: Text(
                  'تفعيل',
                  style: TextStyles.semiBold32(context,
                      color: AppColors.primaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
