import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/onboarding/presentation/view/component/on_boarding_button.dart';

class SecondryPage extends StatelessWidget {
  SecondryPage({super.key});
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              controller: pageController,
              itemCount: features.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  spacing: 90,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 90,
                      child: ClipOval(
                        child: Image.asset(
                          images[index],
                          fit: BoxFit
                              .fill,
                        ),
                      ),
                    ),
                    Text(
                      features[index],
                      style: TextStyles.semiBold32Decoreted(context,
                          color: AppColors.primaryColor),
                    ),
                    Text(
                      texts[index],
                      style: TextStyles.semiBold16(
                          context: context, color: AppColors.black),
                    )
                  ],
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: pageController,
                count: features.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: AppColors.secondryColor,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesConstants.homePageRouteName,
                        (route) => false,
                      );
                    },
                    child: Text('تخطى')),
                onBoardingButton(
                  context: context,
                  name: 'التالى',
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

const List<String> features = <String>[
  'اوقات الصلاة',
  'الاذكار',
  'السبحة الالكترونية',
  'القران الكريم'
];
const List<String> texts = <String>[
  'يتيح لك التطبيق معرفة مواقيت الصلاة بدقة حسب موقعك، مع عد تنازلي يوضح الوقت المتبقي لكل صلاة ، لتكون دائمًا في الموعد وتعيش يومك بإيقاع إيماني منتظم، مع تنبيهات دقيقة تُبقيك على استعداد دائم.',
  "عيش يومك بسلام داخلي مع ميزة الأذكار اليومية، التي توفر لك نصوصًا من الأذكار مع تنبيهات ذكية لتذكيرك بها في أوقات مناسبة، بالإضافة إلى عدّاد زمني ينبهك للمواعيد المهمة وقراءة القرآن الكريم بأعلى درجات السلاسة.",
  'استمتع بتجربة روحانية متكاملة مع السبحة الإلكترونية التي تساعدك في تتبع عدد الذكر، مع إمكانية تسجيل الرقم وحفظه تلقائيًا، أو مسحه بسهولة.',
  'ستمتع بتجربة روحانية مميزة مع عرض كامل للقرآن الكريم، بخط واضح وواجهة مريحة للعين، مع إمكانية التنقل السلس بين السور والأجزاء و مع دعم للوضع الليلي',
];
const List<String> images = <String>[
  'assets/images/صلاة.jpg',
  'assets/images/اذكار.png',
  'assets/images/image.jpeg',
  'assets/images/quran.jpg'
];
