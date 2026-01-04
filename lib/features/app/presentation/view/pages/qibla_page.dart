import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/vibration_button.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/domain/repositories/base_qipla_repo.dart';
import 'package:test_app/features/app/presentation/controller/cubit/qibla_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/qibla_arrow.dart';
import 'package:test_app/features/app/presentation/view/components/qipla_accuracy_button.dart';
import 'package:vibration/vibration.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  final ValueNotifier<bool> vibrationNotifier = ValueNotifier(false);

  double? lastAngle;
  QiblaLoaded? lastSuccessState;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QiblaCubit(sl<BaseQiblaRepository>())..startQibla(),
      child: CustomScaffold(
        appBar: AppBar(
          title: Text(AppStrings.appBarTitles(withTwoLines: false)[6]),
          leading: const GetAdaptiveBackButtonWidget(),
          actions: [
            VibrationButton(vibrationNotifier: vibrationNotifier),
          ],
        ),
        body: BlocBuilder<QiblaCubit, QiblaState>(
          builder: (context, state) {
            if (state is QiblaLoaded) {
              lastSuccessState = state;
            }

            if (lastSuccessState == null && state is QiblaLoading) {
              return const AppLoadingWidget();
            }

            if (lastSuccessState == null) {
              return const SizedBox();
            }

            final qiblaState = lastSuccessState!;

            /// حساب فرق الزاوية الأقصر
            double diff = ((qiblaState.qibla.qiblaDirection -
                        qiblaState.qibla.deviceDirection +
                        540) %
                    360) -
                180;

            final double angle = diff * (pi / 180);

            /// Vibration Logic
            if (vibrationNotifier.value) {
              if (lastAngle == null) {
                lastAngle = angle;
              } else if ((angle - lastAngle!).abs() > 0.02) {
                Vibration.hasVibrator().then((hasVibrator) {
                  if (hasVibrator) {
                    Vibration.vibrate(duration: 20, amplitude: 130);
                  }
                });
                lastAngle = angle;
              }
            }

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: QiplaAccuracyButton(
                      state: qiblaState,
                      isLoading: state is QiblaLoading,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// القبلة (دايمًا موجودة)
                  Expanded(
                    child: Center(
                      child: QiblaArrow(
                        angle: angle,
                        size: 260,
                      ),
                    ),
                  ),

                  /// Error Banner تحت القبلة
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state is QiblaError
                        ? _QiblaFailureBanner(message: state.message)
                        : const SizedBox(),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'زاوية القبلة: ${qiblaState.qibla.qiblaDirection.toStringAsFixed(2)}°',
                  ),
                  Text(
                    'اتجاه الجهاز: ${qiblaState.qibla.deviceDirection.toStringAsFixed(2)}°',
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Banner احترافي للفشل
class _QiblaFailureBanner extends StatelessWidget {
  final String message;

  const _QiblaFailureBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
