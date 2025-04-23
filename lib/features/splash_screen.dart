import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomeCubit(sl(),sl())..getPrayersTimes(context),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.requestStateofPrayerTimes == RequestStateEnum.success) {
            Navigator.pushReplacementNamed(
                context, RoutesConstants.homePageRouteName);
          }
        },
        child: const ColoredBox(
          color: AppColors.primaryColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: 100.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GetAdaptiveLoadingWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
