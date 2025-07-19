import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_cubit.dart';

String get getInitRoute =>sl<OnBoardingCubit>().state ? RoutesConstants.splashScreenRouteName : RoutesConstants.splashScreenRouteName;
