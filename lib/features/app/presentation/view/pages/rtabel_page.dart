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
              leading: const GetAdaptiveBackButtonWidget(),
              actions: [
                Visibility(
                  visible: MediaQuery.of(context).orientation ==
                      Orientation.landscape,
                  child: IconButton(
                    onPressed: () {
                      context.read<RtabelCubit>().resetAllCheckBoxes();
                    },
                    icon: Icon(Icons.refresh),
                  ),
                )
              ],
              title: Text(
                AppStrings.appBarTitles(withTwoLines: false)[5],
              ),
            ),
            body: OrentationLayout(
              landScapeWidget: (context) => LandScapeWidgetToRTablePage(),
              portraitWidget: (context) => Center(
                child: Text(
                    AppStrings.translate("portraitOrientationToRTablePageText"),
                    textAlign: TextAlign.center,
                    style: TextStyles.bold20(context)),
              ),
            ),
          );
        },
      ),
    );
  }
}
