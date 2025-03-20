import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  Offset offset = Offset.zero;
  int counter = 0;
  double opacity = 1.0;
  static const Duration _duration = Duration(milliseconds: 100);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 20, horizontal: context.width * (1 / 3) / 2),
      child: SizedBox(height: context .height * (1 / 3) / 2 + 80,
        child: Stack(clipBehavior: Clip.none,
          children: [
            Container(
              alignment: Alignment.center,
              width: context.width * 2 / 3,
              height: 80,
              decoration: BoxDecoration(
                  color: AppColors.inActivePrimaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  border: Border.all(
                      color: AppColors.primaryColor, width: 4)),
              child: AnimatedSlide(
                duration: _duration,
              offset: offset,
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(seconds: 0),
                  child: Text(
                    counter.toString(),
                    // '${controller.counter}',
                    style: TextStyles.semiBold32(context, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
            Positioned(top: 80 + 15,//80 for container hight and 15 for spacing.
            right: 0.0,
              child: InkWell(
                    // onTap: () => controller.reset(),
                    child: Align(alignment: Alignment.topLeft,
                      child: const Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.secondryColor,
                            radius: 10,
                          ),
                          Text(
                            'reset',
                            style: TextStyle(color: AppColors.purple),
                          )
                        ],
                      ),
                    ),
                  ),
            ),
            Positioned(top: 80 + 15,//80 for container hight and 15 for spacing.
            left: 0.0,right: 0.0,
              child: GestureDetector(
                
                onTap: () { setState(() {
                  opacity = 0.0;
                  offset = Offset(0, -.5);
                });
                Future.delayed(_duration,() => setState(() {
                  counter++;
                  opacity = 1.0;
                  offset = Offset.zero;
                }));
                },
                child: CircleAvatar(
                  radius: context.width * (1 / 3) / 2,
                  // onPressed: () {},
                  // //  onPressed: () => controller.increease(),
                  backgroundColor: AppColors.inActivePrimaryColor,
                  child:  Text(
                    'press',
                    style: TextStyles.semiBold32(context,color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
