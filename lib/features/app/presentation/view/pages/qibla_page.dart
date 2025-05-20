import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/cubit/qibla_cubit.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QiblaCubit(sl<BasePositionService>())..initQibla(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('اتجاه القبلة')),
        body: BlocBuilder<QiblaCubit, QiblaState>(
          builder: (context, state) {
            if (state is QiblaLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is QiblaError) {
              return Center(child: Text(state.message));
            } else if (state is QiblaLoaded) {
              final angle = (state.qiblaDirection - state.deviceDirection) * (pi / 180);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle:  angle - math.pi / 4,
                      child: Icon(CupertinoIcons.compass_fill, size: 200,color: AppColors.primaryColor,),
                    ),
                    SizedBox(height: 20),
                    Text('زاوية القبلة: ${state.qiblaDirection.toStringAsFixed(2)}°'),
                    Text('اتجاه الجهاز: ${state.deviceDirection.toStringAsFixed(2)}°'),
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
