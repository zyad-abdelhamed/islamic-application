import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/features/app/presentation/view/pages/adhkar_page.dart';

class AdhkarButton extends StatefulWidget {
  const AdhkarButton({
    super.key,
    required this.icon,
    required this.text,
    required this.index,
    required this.imagePath,
  });

  final String text, imagePath;
  final IconData icon;
  final int index;

  @override
  State<AdhkarButton> createState() => _AdhkarButtonState();
}

class _AdhkarButtonState extends State<AdhkarButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // تحميل الصورة مسبقًا لتسريع العرض
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(widget.imagePath), context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void flipCard() async {
    setState(() => isFlipped = !isFlipped);
    _controller.forward(from: 0);
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      getAdhkar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double tiltAngle = widget.index.isEven ? 0.05 : -0.05;
    final double scaleFactor = 0.95;

    return GestureDetector(
      onTap: flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * 3.1416;
          final isBack = _animation.value > 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle)
              ..rotateZ(tiltAngle)
              ..scale(scaleFactor),
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.1416),
                    child: _buildBackCard(),
                  )
                : _buildFrontCard(),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyles.bold20(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryColorInActiveColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            color: Theme.of(context).primaryColor,
            size: getResponsiveFontSize(context: context, fontSize: 60),
          ),
          const SizedBox(height: 10),
          Text(
            widget.text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyles.bold20(context)
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  void getAdhkar(BuildContext context) async {
    final result = await sl<GetAdhkarUseCase>()
        .call(parameters: AdhkarParameters(nameOfAdhkar: widget.text));

    result.fold(
      (failure) {},
      (data) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdhkarPage(
              adhkar: data.toSet(),
              scaleNoitfier: ValueNotifier(1.0),
              nameOfAdhkar: widget.text,
            ),
          ),
        );
      },
    );
  }
}
