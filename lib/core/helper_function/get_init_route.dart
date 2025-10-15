import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_controller.dart';

String get getInitRoute {
  final OnBoardingController controller = sl<OnBoardingController>();

  return controller.loadState
      ? RoutesConstants.homePageRouteName
      : RoutesConstants.mainPageOnBoarding;
}
