import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/app/presentation/view/components/land_scape_ramadan_table.dart';
import 'package:test_app/app/presentation/view/components/pages_app_bar.dart';
import 'package:test_app/app/presentation/view/components/portrait_orientation_ramadan_table.dart';

class RamadanTabelPage extends StatelessWidget {
  const RamadanTabelPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RtabelCubit(),
      child: Scaffold(
          appBar: pagesAppBar[2],
          body: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.landscape) {
                return LandScapeWidgetToRTablePage();
              }
              return PortraitOrientationWidgetToRTablePage();
            },
          )),
    );
  }
}
