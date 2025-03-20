import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class ShowAlertDialogWidget extends StatelessWidget {
  const ShowAlertDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(radius: 5.0,backgroundColor: AppColors.primaryColor,),
          TextButton(
            onPressed: () {
              showCupertinoDialog(context: context, builder: (context) => test());
            },
            child: Text(
              'التسابيح بعدالصلاة',
              
              style: TextStyles.semiBold20(context).copyWith(decoration: TextDecoration.underline,color: AppColors.thirdColor),
            ),
          ),
        ],
      ),
    );
  }
}

class test extends StatefulWidget {
  const test({
    super.key,
  });

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(
        () {
          setState(() {});
        },
      );
  }

  int progress = 0;
  String get getText {
    if (progress < 33) {
      return 'سبحان الله';
    } else if (progress < 66) {
      return 'الحمد لله';
    } else if (progress < 99) {
      return 'الله أكبر';
    } else{
      return 'لا إله إلا الله';
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              // boxShadow: ViewConstants.appShadow,
              color: AppColors.primaryColor,
            ),
            margin: EdgeInsets.all(15),
            height: context.height * 3 / 4 + 1/8,
            width: context.width * 3/4,
            padding: EdgeInsets.symmetric(horizontal: context.width * 1/16,vertical: context.height * 1 / 4),
            child: Stack(
              children: [
                Center(
                    child: CustomPaint(size: Size(context.width * .60, context.width * .60),
                  painter: CirclePainter(100, context,AppColors.inActiveThirdColor),)),
                Center(
                    child: CustomPaint(
                  size: Size(context.width * .60, context.width * .60),
                  painter: CirclePainter(progress, context,AppColors.thirdColor),
                )),
                Center(
                  child: TextButton(style: ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                      onPressed: () {
                        progress++;
                        setState(() {});
                        if (progress == 100) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        getText,
                        style: TextStyles.semiBold32(context,
                            color: AppColors.white),
                      )),
                ),
              ],
            ),
          ),
          Positioned(
              top: 0.0,
              right: 0.0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration:BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(200),
        ),
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: AppColors.black,
                    size: 30,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
class CirclePainter extends CustomPainter {
  final int progress;
  final int lastCount = 100;
  final Color lineColor;
  final BuildContext context;

  CirclePainter(this.progress, this.context, this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(
        rect,
        300, //todo
        progress /
            lastCount *
            2 *
            3.14, // 2 * 3.14 = circle so when progress = 100 the circle is complete.
        false,
        paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
