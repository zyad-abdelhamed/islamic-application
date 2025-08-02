import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_page_app_bar.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/view/components/circle_painter.dart';

class AdhkarPage extends StatefulWidget {
  final String nameOfAdhkar;
  final GetAdhkarController getAdhkarController;
  const AdhkarPage(
      {super.key,
      required this.nameOfAdhkar,
      required this.getAdhkarController});

  @override
  State<AdhkarPage> createState() => _AdhkarPageState();
}

class _AdhkarPageState extends State<AdhkarPage> {
  late final AdhkarPageController adhkarPageController;

  @override
  void initState() {
    super.initState();
    adhkarPageController = AdhkarPageController();
    adhkarPageController.initState(context);
  }

  @override
  void dispose() {
    adhkarPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesConstants.homePageRouteName,
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
          appBar: adhkarPageAppBar(context,
              appBarTitle: widget.nameOfAdhkar,
              adhkarPageController: adhkarPageController),
          body: Stack(children: [
            //data
            AnimatedList(
                padding: const EdgeInsets.all(8.0),
                key: adhkarPageController.animatedLIstKey,
                controller: adhkarPageController.adhkarScrollController,
                initialItemCount: widget.getAdhkarController.adhkar.length,
                itemBuilder: (context, index, animation) => AdhkarWidget(
                      adhkarPageController: adhkarPageController,
                      index: index,
                      adhkarEntity:
                          widget.getAdhkarController.adhkar.elementAt(index),
                    )),
            //circle slider
            ValueListenableBuilder<double>(
              valueListenable: adhkarPageController.progressNotfier,
              builder: (_, __, ___) => Stack(children: [
                _getCustomCircleSlider(context,
                    customPainter: CirclePainter(
                        lineSize: 5.0,
                        progress: adhkarPageController.maxProgress,
                        context: context,
                        lineColor: ThemeCubit.controller(context).state ? AppColors.darkModeInActiveColor : AppColors.lightModeInActiveColor,
                        maxProgress: adhkarPageController.maxProgress)),
                _getCustomCircleSlider(context,
                    customPainter: CirclePainter(
                        lineSize: 5.0,
                        progress: adhkarPageController.progressNotfier.value,
                        context: context,
                        lineColor: Theme.of(context).primaryColor,
                        maxProgress: adhkarPageController.maxProgress))
              ]),
            )
          ])),
    );
  }

//   ===helper functions===
  Positioned _getCustomCircleSlider(BuildContext context,
      {required CustomPainter customPainter}) {
    return Positioned(
      bottom: 20.0,
      left: 20.0,
      child: AnimatedOpacity(
        duration: AppDurations.mediumDuration,
        opacity: adhkarPageController.adhkarScrollController.hasClients
            ? adhkarPageController
                    .adhkarScrollController.position.isScrollingNotifier.value
                ? 1.0
                : 0.0
            : 0.0,
        child: CustomPaint(
          size: Size(context.width * .10, context.width * .10),
          painter: customPainter,
        ),
      ),
    );
  }
}
