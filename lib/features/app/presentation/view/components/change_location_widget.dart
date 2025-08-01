import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/cubit/location_cubit.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';

class ChangeLocationWidget extends StatelessWidget {
  const ChangeLocationWidget({
    super.key,
    required this.prayerTimesPageController,
  });

  final PrayerTimesPageController prayerTimesPageController;
  @override
  Widget build(BuildContext context) {
    Color dataColor =
        ThemeCubit.controller(context).state ? Colors.grey : Colors.black;
    return BlocProvider(
      create: (context) => sl<LocationCubit>(),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: 'تنويه: ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'سيتم جلب ',
                  style: TextStyle(
                    color: dataColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: 'مواقيت الصلاة ',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      'بناءً على الموقع المخزن مسبقًا.  يمكنك دائما تغيير الموقع، عن طريق الضغط على ',
                  style: TextStyle(
                    color: dataColor,
                  ),
                ),
                TextSpan(
                  text: 'تحديث الموقع.',
                  style: TextStyle(
                    color: dataColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: dataColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => prayerTimesPageController.updateLocation(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: Colors.black.withValues(alpha: .3),
            radius: 80,
            child: Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_pin,
                  color: dataColor,
                  size: 35,
                ),
                Text(
                  sl<GetPrayersTimesController>().locationEntity.name,
                  textAlign: TextAlign.center,
                  style: TextStyles.semiBold16_120(context)
                      .copyWith(color: dataColor, fontFamily: 'DataFontFamily'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
