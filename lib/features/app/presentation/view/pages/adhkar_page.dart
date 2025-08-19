import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_page_app_bar.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/view/components/common_circle_layout.dart';

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
    const double circleSliderPadding = 15.0;

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
          appBar: AdhkarPageAppBar(
            appBarTitle: widget.nameOfAdhkar,
            adhkarPageController: adhkarPageController,
          ),
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
            // circle slider
            Positioned(
              bottom: circleSliderPadding,
              left: circleSliderPadding,
              child: ListenableBuilder(
                listenable: adhkarPageController.progressNotfier,
                builder: (_, __) => AnimatedOpacity(
                  duration: AppDurations.mediumDuration,
                  opacity: adhkarPageController.isCircleSliderShowed,
                  child: CommonCircleLayout(
                      customPaintSize: context.width * 0.10,
                      lineSize: 8.0,
                      maxProgress: adhkarPageController.maxProgress,
                      progressNotifier: adhkarPageController.progressNotfier),
                ),
              ),
            ),
          ])),
    );
  }
}
