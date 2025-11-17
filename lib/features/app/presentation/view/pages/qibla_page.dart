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
import 'package:test_app/features/app/presentation/view/components/qibla_arrow.dart';
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
              return const AppLoadingWidget();
            }
            if (state is QiblaError) {
              return ErrorWidgetIslamic(message: state.message);
            }
            if (state is QiblaLoaded) {
              // زاوية للـ Transform.rotate تحتاج راديان؛ نحسب الفرق الأقصر بين القيمتين
              double diff = ((state.qibla.qiblaDirection -
                          state.qibla.deviceDirection +
                          540) %
                      360) -
                  180;
              final double angle = diff * (pi / 180);

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: QiplaAccuracyButton(
                          state: state, isLoading: state is QiblaLoading),
                    ),
                    const SizedBox(height: 12),

                    // تنبيه صغير لو لازم معايرة (لو كانت القراءة غير ثابتة فهو فعلاً ينبّه من الريبو)
                    // خطأ المعايرة يظهر فى QiblaError لذا لا نحتاج شرط هنا.

                    Expanded(
                      child: Center(
                        child: QiblaArrow(angle: angle, size: 260),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                        'زاوية القبلة: ${state.qibla.qiblaDirection.toStringAsFixed(2)}°'),
                    Text(
                        'اتجاه الجهاز: ${state.qibla.deviceDirection.toStringAsFixed(2)}°'),
                    const SizedBox(height: 18),
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
