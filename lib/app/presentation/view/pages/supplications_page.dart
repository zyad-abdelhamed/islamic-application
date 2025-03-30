import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/app/presentation/controller/cubit/supplications_cubit.dart';
import 'package:test_app/app/presentation/view/components/custom_switch.dart';
import 'package:test_app/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/app/presentation/view/components/supplication_widget.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/adaptive_widgets/get_adaptive_loading_widget.dart';

class SupplicationsPage extends StatelessWidget {
  final String nameOfAdhkar;
  const SupplicationsPage({super.key, required this.nameOfAdhkar});

  // final ScrollController _scrollController = ScrollController();
  // double _topPaddingValue = 0.0;
  // void upDateTopPadding() {
  //   double maxScroll = _scrollController.position.maxScrollExtent;
  //   double currentScroll = _scrollController.position.pixels;
  //   double screenHight = MediaQuery.of(context).size.height -
  //       MediaQuery.of(context).size.height * .10 //appBar hight
  //       -
  //       5; //slider hight

  //   setState(() {
  //     double g = (currentScroll / maxScroll) * 100;
  //     switch (g) {
  //       case < 0.0:
  //         _topPaddingValue = 0.0;
  //       case < 5.0:
  //         _topPaddingValue = screenHight * .05;
  //       case < 10.0:
  //         _topPaddingValue = screenHight * .10;
  //       case < 15.0:
  //         _topPaddingValue = screenHight * .15;
  //       case < 20.0:
  //         _topPaddingValue = screenHight * .20;
  //       case < 25.0:
  //         _topPaddingValue = screenHight * .25;
  //       case < 30.0:
  //         _topPaddingValue = screenHight * .30;

  //       case < 35.0:
  //         _topPaddingValue = screenHight * .35;
  //       case < 40.0:
  //         _topPaddingValue = screenHight * .40;
  //       case < 45.0:
  //         _topPaddingValue = screenHight * .50;
  //       case < 50.0:
  //         _topPaddingValue = screenHight * .55;
  //       case < 55.0:
  //         _topPaddingValue = screenHight * .60;
  //       case < 60.0:
  //         _topPaddingValue = screenHight * .65;
  //       case < 65.0:
  //         _topPaddingValue = screenHight * .70;
  //       case < 70.0:
  //         _topPaddingValue = screenHight * .75;
  //       case < 75.0:
  //         _topPaddingValue = screenHight * .80;
  //       case < 80.0:
  //         _topPaddingValue = screenHight * .85;
  //       case < 85.0:
  //         _topPaddingValue = screenHight * .90;
  //       case < 90.0:
  //         _topPaddingValue = screenHight * .95;
  //       case < 95.0:
  //         _topPaddingValue = screenHight;

  //       case == 100.0:
  //         _topPaddingValue = screenHight;
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SupplicationsCubit(sl())
          ..getAdhkar(
              AdhkarParameters(nameOfAdhkar: nameOfAdhkar, context: context)),
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
                preferredSize: Size.zero,
                child: BlocBuilder<SupplicationsCubit, SupplicationsState>(
                  builder: (context, state) {
                    return CustomSwitch(
                        value: context.supplicationsController.isDeleted,
                        title: 'الحذف بعد الانتهاء',
                        mainAxisAlignment: MainAxisAlignment.center,
                        onChanged: (bool value) {
                          context.supplicationsController
                              .toggleIsDeletedSwitch();
                        });
                  },
                )),
            toolbarHeight: context.height * .15,
            title: Text(
              nameOfAdhkar,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: BlocBuilder<SupplicationsCubit, SupplicationsState>(
                builder: (context, state) {
              print('supplications page body');
              if (state.adhkarRequestState == RequestStateEnum.failed) {
                return ErorrWidget(message: state.adhkarErorrMessage!);
              } else if (state.adhkarRequestState == RequestStateEnum.success) {
                //case success
                return AnimatedList(
                    key: context.supplicationsController.animatedListKey,
                    initialItemCount: state.adhkar.length,
                    itemBuilder: (context, index, animation) {
                      SupplicationWidget supplicationWidget = SupplicationWidget(
                        index: index,
                        adhkarEntity: state.adhkar[index],
                        state: state,
                      );
                      return context.supplicationsController.isDeleted
                          ? SlideTransition(
                              position: _removeAnimation(animation),
                              child: supplicationWidget)
                          : supplicationWidget;
                    });
              }
              return GetAdaptiveLoadingWidget();
            }),
          ),
          // topPaddingValue: 3,
          // //  _topPaddingValue,
          // visible: false
          // //  _scrollController.hasClients
          // //     ? _scrollController.position.isScrollingNotifier.value
          // //     : false,
          // )),
        ));
  }
}

Animation<Offset> _removeAnimation(Animation<double> animation) {
  return Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
      .animate(animation);
}
