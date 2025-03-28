import 'package:flutter/material.dart';
import 'package:test_app/contact_us_tab_view.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/widgets/custom_button.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ContactUsTabView(),
        // child: MaterialButton(
        //   color: AppColors.primaryColor,
        //   onPressed: () => showModalBottomSheet(
        //     context: context,
        //     builder: (context) => Container(
        //       decoration: BoxDecoration(
        //           color: AppColors.white,
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(20.0),
        //               topRight: Radius.circular(20.0))),
        //       height: context.height * 1 / 3,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Padding(
        //             padding:
        //                 EdgeInsets.symmetric(horizontal: context.width * 1 / 3),
        //             child: Divider(
        //               thickness: 5,
        //               color: AppColors.grey,
        //             ),
        //           ),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 "Delete account",
        //                 style: TextStyles.semiBold32auto(context),
        //               ),
        //               Text(
        //                 'Are you sure you want delete account?',
        //                 style: TextStyles.regular16_120(context,
        //                     color: AppColors.grey),
        //               ),
        //             ],
        //           ),
        //          const BottomSheetButtons(),
        //           SizedBox(
        //             height: 10,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class BottomSheetButtons extends StatelessWidget {
  const BottomSheetButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          spacing: 30.0,
          children: [
            Expanded(
              child: OutlinedButton(
                  style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(double.infinity, context.height * 0.06)),
                      shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15.0)))),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyles.semiBold20(context,
                       ),
                  )),
            ),
            Expanded(
              child: customButton(
                  customButtonInputModel: CustomButtonInputModel(
                context: context,
                buttonName: "Yes",
                onPressedFunction: () {},
              )),
            )
          ],
        ));
  }
}
