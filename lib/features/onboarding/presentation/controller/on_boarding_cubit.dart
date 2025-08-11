import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/constants/routes_constants.dart';

class OnBoardingCubit extends HydratedCubit<bool> {
  OnBoardingCubit() : super(false);

  void toNextPage({
  required BuildContext context,
  required PageController controller,
}) {
  if (!controller.hasClients) return;

  final int page = controller.page?.round() ?? 0;

  if (page == 4) {
    // التنقل فورًا
   goToHomePage(context: context);
    return;
  }

  controller.jumpToPage(page + 1);
}


  void goToHomePage({required BuildContext context}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesConstants.locationPermissionPage,
      (route) => false,
    );
  }

  emitToTrue() => emit(true);

  @override
  bool fromJson(Map<String, dynamic> json) {
    return json[CacheConstants.isDisplayed] as bool? ?? false;
  }

  @override
  Map<String, dynamic> toJson(bool state) {
    return {CacheConstants.isDisplayed: state};
  }
}
