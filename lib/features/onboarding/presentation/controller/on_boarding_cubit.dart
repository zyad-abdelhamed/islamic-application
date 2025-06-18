import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/constants/routes_constants.dart';

class OnBoardingCubit extends HydratedCubit<bool> {
  OnBoardingCubit() : super( false);
  final PageController pageController = PageController();
  int isLastPage = 0;
  void animateToNextPage({required BuildContext context}) {
    isLastPage = pageController.page!.round();
    if (isLastPage == 4) {
      goToHomePage(context: context);
    }
    pageController.nextPage(
        duration: const Duration(milliseconds: 1), curve: Easing.legacy);
  }

  void goToHomePage({required BuildContext context}) {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesConstants.homePageRouteName, (route) => false);
    emit(true);
  }

  @override
  bool fromJson(Map<String, dynamic> json) {
    return json[CacheConstants.isDisplayed] as bool? ?? false;
  }

  @override
  Map<String, dynamic> toJson(bool state) {
    return {CacheConstants.isDisplayed: state};
  }
}
