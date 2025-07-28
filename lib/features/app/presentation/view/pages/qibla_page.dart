import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/cubit/qibla_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QiblaCubit(sl<BaseLocationService>())..initQibla(),
      child: Scaffold(
        appBar: AppBar(
            leading: GetAdaptiveBackButtonWidget(),
            title: Text(AppStrings.appBarTitles(withTwoLines: false)[3])),
        body: BlocBuilder<QiblaCubit, QiblaState>(
          builder: (context, state) {
            if (state is QiblaLoading) {
              return GetAdaptiveLoadingWidget();
            } else if (state is QiblaError) {
              const double spacing = 5;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: spacing,
                children: [Spacer(),
                  ErorrWidget(message: state.message),Spacer(),
                  OutlinedButton(onPressed: () async{
                    await sl<BaseLocationService>().requestPermission;
                  },child: Text('request location permission',style: TextStyle(color: AppColors.primaryColor),),)
                ],
              );
            } else if (state is QiblaLoaded) {
              final double angle =
                  (state.qiblaDirection - state.deviceDirection) * (pi / 180);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: angle ,
                      child:Image.asset('assets/images/ooooo.png',fit: BoxFit.fill,)
                    ),
                    const SizedBox(height: 20),
                    Text(
                        'زاوية القبلة: ${state.qiblaDirection.toStringAsFixed(2)}°'),
                    Text(
                        'اتجاه الجهاز: ${state.deviceDirection.toStringAsFixed(2)}°'),
                  ],
                ),
              );
            }
            return Center(child: Text('جارٍ التحميل...'));
          },
        ),
      ),
    );
  }
}
