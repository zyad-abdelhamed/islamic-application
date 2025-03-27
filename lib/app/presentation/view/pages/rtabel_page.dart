import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/app/presentation/view/components/land_scape_ramadan_table.dart';
import 'package:test_app/app/presentation/view/components/portrait_orientation_ramadan_table.dart';
import 'package:test_app/core/constants/routes_constants.dart';

class RamadanTabelPage extends StatelessWidget {
  const RamadanTabelPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
          
            Navigator.pushNamedAndRemoveUntil(context,RoutesConstants.homePageRouteName , (route) => false,);
             SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
          }, icon: Icon(Icons.arrow_back)),
          title: Text(
            'يومى ف رمضان',
          ),
        ),
        body:
            //    BlocProvider(
            // create: (context) => RtabelCubit(),
            // child: BlocBuilder<RtabelCubit, RtabelState>(
            //   builder: (context, state) {
            //     final RtabelCubit controller = context.read<RtabelCubit>();
            //     return
            Directionality(
          textDirection: TextDirection.rtl,
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.landscape) {
                return LandScapeWidgetToRTablePage();
              }
              return PortraitOrientationWidgetToRTablePage();
            },
          ),
        ));
  }
}
