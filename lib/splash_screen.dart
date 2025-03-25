import 'package:flutter/material.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'dart:math';

import 'package:test_app/core/utils/responsive_extention.dart';

class SplashScreen extends StatelessWidget {
  final random = Random();
  List<String> ran = [
    'روى عن عبد الله بن عمرو -رضي الله عنه- أنه قال: (لَمْ يَكُنِ النبيُّ صَلَّى اللهُ عليه وسلَّمَ فَاحِشًا ولَا مُتَفَحِّشًا، وكانَ يقولُ: إنَّ مِن خِيَارِكُمْ أحْسَنَكُمْ أخْلَاقًا).',
    'قال رسول الله صلى الله عليه وسلم: (ما مِن شيءٍ أثقلُ في الميزانِ من حُسنِ الخُلُقِ).',
    'قال رسول الله صلى الله عليه وسلم: (إنَّ مِن أحبِّكم إليَّ وأقربِكُم منِّي مجلسًا يومَ القيامةِ أحاسنَكُم أخلاقًا).',
    'قال رسول الله صلى الله عليه وسلم: (إنَّ المؤمنَ ليُدْرِكُ بحُسْنِ خُلُقِه درجةَ الصَّائمِ القائمِ).',
    'قال رسول الله صلى الله عليه وسلم: (إنَّ أكملَ أو من أكملِ المؤمنين إيمانًا أحسنُهم خُلقًا).',
    'قال رسول الله صلى الله عليه وسلم: (أحَبُّ عبادِ اللهِ إلى اللهِ أحسَنُهُمْ خُلُقًا).',
    'سئل رسول الله -صلى الله عليه وسلم- عن أكثر شيء يُدخل الناس الجنة، فقال: (تَقْوَى اللهِ وحُسْنُ الخُلُقِ)',
    'قال رسول الله صلى الله عليه وسلم: (إنَّما بُعِثْتُ لأُتممَ صالحَ الأخلاقِ).',
    'قال رسول الله -صلى الله عيه وسلم-: (مَن كانَ آخرُ كلامِه لا إلَه إلَّا اللَّهُ، دخلَ الجنَّةَ).',
    'قال رسول الله -صلى الله عيه وسلم-: (إنَّ الرَّجُلَ لَيَعْمَلُ الزَّمَنَ الطَّوِيلَ بِعَمَلِ أَهْلِ النَّارِ، ثُمَّ يُخْتَمُ له عَمَلُهُ بِعَمَلِ أَهْلِ الجَنَّةِ).',
    'قال رسول الله -صلى الله عيه وسلم-: (ثلاثةٌ كلُّهم ضامنٌ على اللهِ إن عاش كُفِيَ، و إن مات دخل الجنةَ: من دخل بيتَه بسلامٍ فهو ضامنٌ على اللهِ عزَّ و جلَّ و من خرج إلى المسجدِ فهو ضامنٌ على اللهِ و من خرج في سبيل اللهِ فهو ضامنٌ على اللهِ).',
    'قال رسول الله -صلى الله عيه وسلم-: (من ماتَ وَهوَ بريءٌ منَ الْكبرِ والغُلولِ والدَّينِ دخلَ الجنَّةَ).',
    'قال رسول الله -صلى الله عيه وسلم-: (الطاعونُ، والمبطونُ، والغريقُ، والنُّفَساءُ: شهادةٌ).',
  ];

  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final randomIndex = random.nextInt(ran.length);
    final randomItem = ran[randomIndex];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          spacing: context.height / 8,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 1 / 16,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 3 / 4,
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         fit: BoxFit.fill,
              //         image: AssetImage(
              //           'images/kaba.jpg',
              //         ))),
              child: ListTile(
                title: const Text(
                  'حديث اليوم|',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: Text(
                  randomItem,
                  style: const TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesConstants.homePageRouteName,
                  (route) => false,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    child: Text(
                      "ابدأ",
                      style:
                          TextStyles.semiBold32(context, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0))),
                    child: Text(
                      "الان",
                      style:
                          TextStyles.semiBold32(context, color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
