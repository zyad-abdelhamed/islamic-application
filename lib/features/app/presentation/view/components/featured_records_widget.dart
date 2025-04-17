import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/components/featuerd_records_bloc_builder.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class FeatuerdRecordsWidget extends StatelessWidget {
  const FeatuerdRecordsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150 * 1.5,
      margin: const EdgeInsets.only(bottom: 35.0),
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
      ),
      child: Column(
        children: [
          Divider(
            thickness: 5,
            color: Colors.grey,
//main container have 150 150 width so we make horizontal divider width 50 over set atribites indent and endindent both = 50
            indent: 50,
            endIndent: 50,
          ),
          Center(
            child: Text(
              'الريكوردات المميزه',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => showDeleteAlertDialog(
                        context,
                        deleteFunction: () {
                          Navigator.pop(context);

                          context.featuerdRecordsController
                              .deleteAllFeatuerdRecords(context);
                        },
                      ),
                  child: Text('  حذف الكل',
                      style: TextStyles.regular14_150(context)
                          .copyWith(color: AppColors.thirdColor))),
              Divider(
                thickness: 3,
              ),
            ],
          ),
          Expanded(child: FeatuerdRecordsBlocBuilder()),
        ],
      ),
    );
  }
}

//alert dialog
void showDeleteAlertDialog(BuildContext context,
    {required VoidCallback deleteFunction}) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        actionsAlignment: MainAxisAlignment.start,
        title: Text('هل أنت متأكد؟'),
        actions: [
          OutlinedButton(
              onPressed: deleteFunction,
              style: _outlinedButtonStyle,
              child: Text(
                'نعم',
                style: TextStyles.regular16_120(context,
                    color: AppColors.primaryColor),
              )),
          OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: _outlinedButtonStyle,
              child: Text('لا',
                  style: TextStyles.regular16_120(context,
                      color: AppColors.primaryColor)))
        ],
      );
    },
  );
}

ButtonStyle _outlinedButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
        ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15.0))));
