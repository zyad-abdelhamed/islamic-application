import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Visibility(
          visible: state.requestStateofPrayerTimes == RequestStateEnum.loading,
          child:  ColoredBox(
            color: AppColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100.0,top:context.height*3/4 ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GetAdaptiveLoadingWidget(),
              ),
            ),
          ),
        );
      },
    );
  }

  
}
