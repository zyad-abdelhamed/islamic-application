import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/land_scape_ramadan_table.dart';
import 'package:test_app/features/app/presentation/view/components/portrait_orientation_ramadan_table.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class RamadanTabelPage extends StatelessWidget {
  const RamadanTabelPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
            create: (context) => RtabelCubit(sl(), sl(), sl())..loadCheckBoxValues(),
            child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   RoutesConstants.homePageRouteName,
                //   (route) => false,
                // );
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(
            ViewConstants.appBarTitles(withTwoLines: false)[2],
          ),
        ),
        body: OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return LandScapeWidgetToRTablePage();
                }
                return PortraitOrientationWidgetToRTablePage();
              },
            )));
  }
}
