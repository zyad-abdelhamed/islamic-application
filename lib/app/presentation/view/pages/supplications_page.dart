import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/custom_switch.dart';
import 'package:test_app/app/presentation/view/components/slider_widget.dart';
import 'package:test_app/app/presentation/view/components/supplication_widget.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/utils/sized_boxs.dart';

class Morning extends StatefulWidget {
  const Morning({super.key});

  @override
  State<Morning> createState() => _MorningState();
}

class _MorningState extends State<Morning> {
  final ScrollController _scrollController = ScrollController();
  double _topPaddingValue = 0.0;
  void upDateTopPadding() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double screenHight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.height * .10 //appBar hight
        -
        5; //slider hight

    setState(() {
      double g = (currentScroll / maxScroll) * 100;
      switch (g) {
        case < 0.0:
          _topPaddingValue = 0.0;
        case < 5.0:
          _topPaddingValue = screenHight * .05;
        case < 10.0:
          _topPaddingValue = screenHight * .10;
        case < 15.0:
          _topPaddingValue = screenHight * .15;
        case < 20.0:
          _topPaddingValue = screenHight * .20;
        case < 25.0:
          _topPaddingValue = screenHight * .25;
        case < 30.0:
          _topPaddingValue = screenHight * .30;

        case < 35.0:
          _topPaddingValue = screenHight * .35;
        case < 40.0:
          _topPaddingValue = screenHight * .40;
        case < 45.0:
          _topPaddingValue = screenHight * .50;
        case < 50.0:
          _topPaddingValue = screenHight * .55;
        case < 55.0:
          _topPaddingValue = screenHight * .60;
        case < 60.0:
          _topPaddingValue = screenHight * .65;
        case < 65.0:
          _topPaddingValue = screenHight * .70;
        case < 70.0:
          _topPaddingValue = screenHight * .75;
        case < 75.0:
          _topPaddingValue = screenHight * .80;
        case < 80.0:
          _topPaddingValue = screenHight * .85;
        case < 85.0:
          _topPaddingValue = screenHight * .90;
        case < 90.0:
          _topPaddingValue = screenHight * .95;
        case < 95.0:
          _topPaddingValue = screenHight;

        case == 100.0:
          _topPaddingValue = screenHight;
      }
    });
  }

  late Animation<Offset> counterAnimation;
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  String t = 8.toString();
  bool delete = false;
  @override
  Widget build(BuildContext context) {
    print(context.height);
    // return  BlocBuilder<NightCubit, NightState>(
    //   builder: (context, state) {
    //     final NightCubit controller = context.read<NightCubit>();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  preferredSize: Size.zero,
                  child: CustomSwitch(
                      value: delete,
                      title: 'الحذف بعد الانتهاء',
                      mainAxisAlignment: MainAxisAlignment.center,
                      onChanged: (bool value) => setState(() {
                            delete = true;
                            value = delete;
                          }))),
              toolbarHeight: context.height * .15,
              title: Text(
                "أذكار الصباح",
              ),
              centerTitle: true,
            ),
            body: SliderWidget(
              scrollableWidget: AnimatedList(
                  key: animatedListKey,
                  initialItemCount: wordsm.length,
                  itemBuilder: (context, index, animation) => delete
                      ? SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset(1, 0), end: Offset(0, 0))
                              .animate(animation),
                          child: SupplicationWidget(
                              index: index,
                              function: () async {
                                wordsm[index]['num']--;
                                setState(() {});
                                if (wordsm[index]['num'] == 0) {
                                  animatedListKey.currentState!.insertItem(0,
                                      duration:
                                          const Duration(milliseconds: 500));
                                }
                              },
                              list: wordsm))
                      : SupplicationWidget(
                          index: index,
                          function: () async {
                            wordsm[index]['num']--;
                            setState(() {});
                          },
                          list: wordsm)),
              topPaddingValue: _topPaddingValue,
              visible: _scrollController.hasClients
                  ? _scrollController.position.isScrollingNotifier.value
                  : false,
            )));
    //   },
    // );
  }
}

/////////////morning
final List wordsm = [
  {
    "word":
        " اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ",
    "num": 1
  },
  {
    "word":
        "قُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ",
    'num': 3
  },
  {
    'word':
        'قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
    "num": 3
  },
  {
    'word':
        'قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ',
    "num": 3
  },
  {
    'word':
        'اصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر',
    "num": 1
  },
  {
    'word':
        'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ',
    "num": 1
  },
  {
    'word':
        'رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً ',
    "num": 3
  },
  {
    'word':
        'اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك. ',
    "num": 4
  },
  {
    'word':
        'اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر',
    "num": 1
  },
  {
    'word':
        'حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم',
    "num": 7
  },
  {
    'word':
        'بسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم',
    "num": 3
  },
  {
    'word':
        'اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور',
    "num": 1
  },
  {
    'word':
        'أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ',
    "num": 1
  },
  {
    'word':
        'سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه',
    "num": 3
  },
  {
    'word':
        'اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ ',
    "num": 3
  },
  {
    'word':
        'اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ',
    "num": 3
  },
  {
    'word':
        'اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي',
    "num": 1
  },
  {
    'word':
        ' يَا حَيُّ يَا قيُّومُ بِرَحْمَتِكَ أسْتَغِيثُ أصْلِحْ لِي شَأنِي كُلَّهُ وَلاَ تَكِلْنِي إلَى نَفْسِي طَـرْفَةَ عَيْنٍ',
    "num": 3
  },
  {
    'word':
        'أَصْبَـحْـنا وَأَصْبَـحْ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه. ',
    "num": 1
  },
  {
    'word':
        'اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِرْكِهِ ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم',
    "num": 1
  },
  {
    'word': 'أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق',
    "num": 3
  },
  {
    'word': 'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد',
    "num": 10
  },
  {
    'word':
        'اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ',
    "num": 3
  },
  {
    'word':
        'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَال ',
    "num": 3
  },
  {
    'word':
        'يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ',
    "num": 3
  },
  {
    'word':
        'لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ',
    "num": 100
  },
  {
    'word':
        'اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْعَظِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ',
    "num": 1
  },
  {'word': 'سُبْحـانَ اللهِ وَبِحَمْـدِهِ', "num": 100},
  {'word': 'أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ', "num": 100}
];
