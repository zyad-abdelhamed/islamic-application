import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/repositories/base_qipla_repo.dart';
import 'package:test_app/features/app/presentation/controller/cubit/qibla_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/qipla_accuracy_button.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QiblaCubit(sl<BaseQiblaRepository>())..startQibla(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.appBarTitles(withTwoLines: false)[6]),
          leading: const GetAdaptiveBackButtonWidget(),
        ),
        body: BlocBuilder<QiblaCubit, QiblaState>(
          builder: (context, state) {
            if (state is QiblaLoading) {
              return const GetAdaptiveLoadingWidget();
            }
            if (state is QiblaError) {
              return ErrorWidgetIslamic(message: state.message);
            }
            if (state is QiblaLoaded) {
              final double angle =
                  (state.qibla.qiblaDirection - state.qibla.deviceDirection) *
                      (pi / 180);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // زر تغيير الدقة
                    Align(
                        alignment: Alignment.topRight,
                        child: QiplaAccuracyButton(
                            state: state, isLoading: state is QiblaLoading)),
                    const Spacer(),
                    Transform.rotate(
                      angle: angle,
                      child: Image.asset(
                        'assets/images/ooooo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                        'زاوية القبلة: ${state.qibla.qiblaDirection.toStringAsFixed(2)}°'),
                    Text(
                        'اتجاه الجهاز: ${state.qibla.deviceDirection.toStringAsFixed(2)}°'),
                    const Spacer(),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
