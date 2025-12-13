import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/core/widgets/app_main_container.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/core/widgets/toggle_theme_temporarily_button.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_page_app_bar.dart';
import 'package:test_app/features/app/presentation/view/components/common_circle_layout.dart';

class AdhkarPage extends StatefulWidget {
  final String nameOfAdhkar;
  final Set<AdhkarEntity> adhkar;
  final ValueNotifier<double> scaleNoitfier;

  const AdhkarPage({
    super.key,
    required this.nameOfAdhkar,
    required this.adhkar,
    required this.scaleNoitfier,
  });

  @override
  State<AdhkarPage> createState() => _AdhkarPageState();
}

class _AdhkarPageState extends State<AdhkarPage> {
  late final AdhkarPageController adhkarPageController;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    adhkarPageController = AdhkarPageController();
    adhkarPageController.initState(context, widget.adhkar);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scaleNoitfier.value = 1.0;

      // _insertOverlay();
    });
  }

  // ignore: unused_element
  void _insertOverlay() {
    // نتأكد إن الـ OverlayEntry مش مضاف قبل كده عشان ما يتكررش
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 16,
        left: 16,
        child: Material(
          color: Colors.transparent,
          child: ListenableBuilder(
            listenable: adhkarPageController.progressNotfier,
            builder: (_, __) => Offstage(
              // Offstage: عشان نقدر نخفي الدايرة بدون ما نشيلها من الشجرة،
              // وبالتالي نحافظ على حالتها ونمنع إعادة بناء كامل.
              offstage: !adhkarPageController.isCircleSliderShowed,
              child: CommonCircleLayout(
                  customPaintSize: context.width * 0.10,
                  lineSize: 8.0,
                  maxProgress: adhkarPageController.maxProgress,
                  progressNotifier: adhkarPageController.progressNotfier),
            ),
          ),
        ),
      ),
    );
    // إدخال الـ OverlayEntry في الـ Overlay الرئيسي
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    //_overlayEntry?.remove();
    adhkarPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AdhkarPageAppBar(
        appBarTitle: widget.nameOfAdhkar,
        adhkarPageController: adhkarPageController,
      ),
      body: AnimatedList.separated(
        // ملاحظة مهمة حول الأداء:
        //
        // في Flutter فيه فرق بين "إعادة البناء" (Rebuild) و "إعادة الرسم" (Repaint):
        //
        // - إعادة البناء (Rebuild):
        //   بتحصل لما Flutter يعيد استدعاء build() للودجات.
        //   ده بيحصل مثلاً مع setState أو ValueNotifier.
        //   العملية دي خفيفة نسبيًا لأنها بتتعامل مع Widgets (وصف للشكل)
        //   مش مع الرسم الفعلي على الشاشة.
        //
        // - إعادة الرسم (Repaint):
        //   بتحصل لما RenderObject يحتاج يرسم نفسه من جديد على الـ Canvas.
        //   زي مثلاً CustomPainter بيرسم دائرة أو ProgressIndicator بيحدث قيمته.
        //   العملية دي أثقل من الـ Rebuild لأنها بتتعامل مع البكسلات مباشرة.
        //
        // في حالتنا:
        // - AnimatedList ممكن تعمل Rebuild أثناء الاسكرول (عادي ومش مكلف قوي).
        // - لكن CommonCircleLayout (اللي بيرسم دائرة مخصصة) بيعمل Repaint
        //   كتير جدًا مع كل تحديث للـ progress.
        //   عشان كده لفيناه بـ RepaintBoundary => [موجود في CommonCircleLayout عشان اي مكان في المشروع مستخدم الكلاس دهه]:
        //   ده بيعزل الودجت بحيث إعادة الرسم بتاعته ما تجبرش باقي الشاشة تتعاد رسمها.
        //
        // النتيجة:
        // - Flutter هيعيد رسم الجزء الخاص بالدايرة بس.
        // - ده يقلل الحمل على الـ GPU ويخلي الاسكرول والأنيميشن أسلس.

        //   ===امتي احط RepaintBoundary===

        /*
          Checklist: أحط RepaintBoundary هنا؟
          
          هل الويدجت فيها رسم مخصص (CustomPaint / ShaderMask / ClipPath / ImageFilter)؟
          
          نعم → غالبًا محتاج RepaintBoundary.
          
          لا → روح للسؤال اللي بعده.
          
          هل الويدجت بتتغير أو تتأنيمت كل فريم (زي progress أو slider شغال باستمرار)؟
          
          نعم → حط RepaintBoundary حوالين الجزء ده فقط، عشان ما يجرش باقي الشاشة في الـ repaint.
          
          لا → مش ضروري.
          
          هل الويدجت كبيرة أو فيها محتوى ثابت (زي صورة كبيرة أو رسم تقيل)؟
          
          نعم → RepaintBoundary هيساعد يحافظ على الكاش.
          
          لا → غالبًا مش مهم.
          
          هل لاحظت في الـ performance overlay إن الـ repaint area أكبر من اللازم؟
          
          نعم → اعزل الجزء المتغير بريبينت.
          
          لا → سيبها زي ما هي.
          
          هل فيه أجزاء UI مش مرتبطة ببعض؟ (مثلاً أوفرلاي/بادج/دائرة تقدم)
          
          نعم → اعزلهم بريبينت.
          
          لا → مش لازم.
          */

        //   ===ملحوظات===

        /*
          1. يعني إيه RepaintBoundary أصلاً؟
          
          هو زي "عازل" بيقول لـ Flutter: "ارسم الجزء ده مرة واحدة، ولو باقي الصفحة اتعملها Rebuild، متعيدش رسمه إلا لو هو نفسه اتغير".
          
          النتيجة → تمنع أي إعادة رسم زائدة حوالين الـ widget.
          
          2. الحالة العادية (Widget مش بيتغير كتير)
          
          مثلاً عندك صورة (Image) ثابتة جوا ListView:
          
          من غير RepaintBoundary → كل ما يتعمل scroll، Flutter ممكن يضطر يرسم الصورة تاني مع باقي العناصر.
          
          مع RepaintBoundary → Flutter هيكاش الصورة، ومش هيرسمها تاني إلا لو الصورة نفسها اتغيرت.
          
          ده يكسب أداء كبير.
          
          3. الحالة اللي بتتكلم عنها (Widget بيتغير كل فريم)
          
          زي Progress Circle معمول بـ CustomPaint أو Animation:
          
          ده بيتغير في كل فريم (60 مرة في الثانية).
          
          بالتالي Flutter لازم يرسمه من الأول كل فريم → هنا RepaintBoundary مش هيقلل شغل الرسم جوا الدايرة نفسها.
          
          لكن! لو مفيش RepaintBoundary → Flutter ممكن يعيد رسم حاجات تانية جنبه أو فوقه أو تحته (لأنه مش معزول).
          
          مع RepaintBoundary → انت ضمنت إن التأثير التقيل متعزل، وباقي الصفحة مش هيتأثر.
          
          4. الخلاصة
          
          لو الرسم ثابت → RepaintBoundary = مكسب كبير.
          
          لو الرسم متغير باستمرار → المكسب الأساسي إنك بتحمي باقي الـ UI من إعادة الرسم معاه، مش إن الدايرة نفسها هتبقى أسرع.
          
          5. الحاجات دي بالذات ( CustomPaint / ShaderMask / ClipPath / ImageFilter ) تعتبر high-cost widgets لأنها بتجبر Flutter يرسم pixels من الأول بدل ما يعيد استخدام الرسم اللي في الكاش.
          
          6. Rebuild = لما البيانات أو State تتغير → Flutter يبني شجرة Widgets جديدة.
          
          Repaint = لما الشكل المرئي لازم يتعاد رسمه (Canvas) زي تغييرات في صفات كونتينر.
          */

        //   ===سوال مهم===

        /*
          طب ليه مثلا لو عاملين انيمشن مبنعملش ريبين 
          ChatGPT said:
          
          سؤال ممتاز 👌
          خليني أفرقلك بين Animation وبين RepaintBoundary عشان الصورة تبقى أوضح:
          
          1. الأنيميشن في Flutter
          
          مش كل Animation = Repaint.
          
          في Flutter عندنا نوعين:
          
          Property animations (زي Opacity, Transform.scale, Positioned, Align… إلخ): دي بتستخدم GPU وبتتطبق كـ layer transform، فمبتحتاجش Repaint أصلاً. يعني الصورة أو الودجت مش بيتعاد رسمه، بيتاخد زي ما هو ويتحرك/يتغير حجمه/يتقلب بالـ GPU → سريع جدًا.
          
          Custom animations (زي اللي معمول بـ CustomPainter أو ShaderMask أو ImageFilter): دي بتتطلب إعادة رسم كل فريم لأن محتوى الـ pixels نفسه بيتغير.
          
          2. RepaintBoundary
          
          وظيفته إنه يقول:
          "لما تعمل إعادة رسم للـ widget ده، متأثرش على الباقي".
          
          مش معناه يمنع الـ repaint نفسه.
          
          يعني لو عندك Progress Circle معمول بـ CustomPainter → ده لازم يتعاد رسمه كل frame (لأن الخطوط نفسها بتتغير). بس RepaintBoundary بيخلي التأثير confined جواه.
          
          3. ليه مش بنحط RepaintBoundary حوالين كل Animation؟
          
          لو الأنيميشن بيتعمل بالـ GPU (Transform, Opacity, Position…) → ملهاش لازمة لأن مفيش repaint أصلاً، مجرد حركة Layer.
          
          لو الأنيميشن بيغير Pixels (زي CustomPaint) → RepaintBoundary مفيد عشان يمنع باقي الـ UI من إعادة الرسم.
          
          ✅ الخلاصة:
          
          Animations المعتمدة على Layers (GPU) → مش محتاجة RepaintBoundary.
          
          Animations المعتمدة على رسمة جديدة كل Frame → يفضل تتحط جوا RepaintBoundary.
          */
        padding: const EdgeInsets.all(8.0),
        key: adhkarPageController.animatedLIstKey,
        controller: adhkarPageController.adhkarScrollController,
        initialItemCount: widget.adhkar.length + 1,
        separatorBuilder: (_, index, ___) => index == 0
            ? const SizedBox(height: 20.0)
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Divider(),
              ),
        removedSeparatorBuilder: (_, __, ___) => const Divider(),
        itemBuilder: (context, index, animation) {
          return index == 0
              ? AppMainContainer(
                  height: 150,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ToggleThemeTemporarilyButton(),
                      ValueListenableBuilder(
                          valueListenable: adhkarPageController.switchNotfier,
                          builder: (context, value, child) {
                            return AdaptiveSwitch(
                              mainAxisAlignment: MainAxisAlignment.center,
                              name:
                                  AppStrings.translate("adhkarPageSwitchText"),
                              onChanged: (_) {
                                adhkarPageController.toggleIsDeletedSwitch();
                              },
                              value: adhkarPageController.switchNotfier.value,
                            );
                          }),
                    ],
                  ),
                )
              : AdhkarWidget(
                  key: ObjectKey(widget.adhkar.elementAt(index - 1)),
                  adhkarPageController: adhkarPageController,
                  index: index - 1,
                  adhkarEntity: widget.adhkar.elementAt(index - 1),
                );
        },
      ),
    );
  }
}
