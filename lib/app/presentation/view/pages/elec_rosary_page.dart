import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
class ElecRosaryPage extends StatelessWidget {
  const ElecRosaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return
    //  BlocBuilder<elec_rosary_controller, elec_rosary_states>(
    //     builder: (context, state) {
    //   final elec_rosary_controller controller =
    //       context.read<elec_rosary_controller>();
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('السبحه الالكترونيه'),),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation != Orientation.landscape) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: context.width * .50),
                    child: FeatuerdRecordsWidget(),
                  ),
                  CounterWidget(),
                  MaterialButton(
                    onPressed: () async {
                      //  controller.add(context);
                    },
                    color: AppColors.thirdColor,
                    child: Text('حفظ', style: TextStyles.semiBold20(context)),
                  ),
                ],
              );
            } else {
              //todo
              return Scaffold();
            }
          },
        ),
      ),
    );
  }
}