import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/orentation_layout.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/land_scape_ramadan_table.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class RamadanTabelPage extends StatelessWidget {
  const RamadanTabelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RtabelCubit(sl(), sl(), sl())..loadCheckBoxValues(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: GetAdaptiveBackButtonWidget(),
              actions: [
                Visibility(
                  visible: MediaQuery.of(context).orientation ==
                      Orientation.landscape,
                  child: IconButton(
                    onPressed: () {
                      context.read<RtabelCubit>().resetAllCheckBoxes();
                    },
                    icon: Icon(Icons.refresh, color: Colors.white),
                  ),
                )
              ],
              title: Text(
                AppStrings.appBarTitles(withTwoLines: false)[2],
              ),
            ),
            body: OrentationLayout(
              landScapeWidget: (context) => LandScapeWidgetToRTablePage(),
              portraitWidget: (context) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 200.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, right: 8.0, left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.portraitOrientationToRTablePageText,
                          style: TextStyles.bold20(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
