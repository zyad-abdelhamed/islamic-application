import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/alquran_alkarim_page.dart';
import 'package:test_app/features/app/presentation/view/pages/elec_rosary_page.dart';
import 'package:test_app/features/app/presentation/view/pages/qibla_page.dart';
import 'package:test_app/features/app/presentation/view/pages/rtabel_page.dart';
import 'package:test_app/features/app/presentation/view/pages/surahs_page.dart';

abstract class AppStrings {
  //   ===genral===
  static List<String> appBarTitles({required bool withTwoLines}) {
    String getNewlineOrWightSpace() => withTwoLines ? '\n ' : ' ';
    return <String>[
      'القرآن${getNewlineOrWightSpace()}الكريم',
      'تفسير${getNewlineOrWightSpace()}القرآن',
      'السبحه${getNewlineOrWightSpace()}الالكترونيه',
      'جدول${getNewlineOrWightSpace()}رمضان',
      'اتجاه${getNewlineOrWightSpace()}القبله'
    ];
  }

  static const String back = "العوده";
  static const String cachedErrorMessage = '';
  //   ===on boarding===
  static const String skip = 'تخطى';
  static const String next = 'التالى';
  //   ===location permission page===
  static const String usesOfActivationLocation = '''
    لكي تتمكن من استخدام:

    • مواقيت الصلاة حسب موقعك\n• تحديد اتجاه القبلة بدقة"
  ''';
  static const String activationLocationNow = "تفعيل الموقع الآن";
  static const String activationLocationRequired = "تفعيل الموقع مطلوب";
  static const String saveLocation = "حفظ الموقع";
  static const String gotIt = 'فهمت';
  static const String deniedLocationPermissionAlertDialogText =
      'تم رفض إذن خدمة الموقع.\n\n'
      'لن تتمكن من استخدام الميزات التالية:\n'
      '• مواقيت الصلاة حسب موقعك\n'
      '• تحديد اتجاه القبلة بدقة\n\n'
      'سيتم عرض هذه الرسالة في الصفحة الرئيسية، ويمكنك تغيير الإعدادات لاحقًا من هذه الرسالة.';
  static const List<String> features = <String>[
    'اوقات الصلاة',
    'الاذكار',
    'السبحة الالكترونية',
    'القرآن الكريم',
    'اتجاه القبله'
  ];
  static const List<String> texts = <String>[
    'يتيح لك التطبيق معرفة مواقيت الصلاة بدقة حسب موقعك، مع عد تنازلي يوضح الوقت المتبقي لكل صلاة ، لتكون دائمًا في الموعد وتعيش يومك بإيقاع إيماني منتظم، مع تنبيهات دقيقة تُبقيك على استعداد دائم.',
    "عيش يومك بسلام داخلي مع ميزة الأذكار اليومية، التي توفر لك نصوصًا من الأذكار مع تنبيهات ذكية لتذكيرك بها في أوقات مناسبة.",
    'استمتع بتجربة روحانية متكاملة مع السبحة الإلكترونية التي تساعدك في تتبع عدد الذكر، مع إمكانية تسجيل الرقم وحفظه تلقائيًا، أو مسحه بسهولة.',
    'ستمتع بتجربة روحانية مميزة مع عرض كامل للقرآن الكريم، بخط واضح وواجهة مريحة للعين، مع إمكانية التنقل السلس بين السور والأجزاء و مع دعم للوضع الليلي',
    'استمتع بسهولة تحديد اتجاه القبلة بدقة، عبر بوصلة مدمجة وداعمة للوضع الليلي.'
  ];
  //   ===splash screen===
  static const String loadingText = 'يتم التحميل...';
  //   ===home page===
  static const String darkMode = 'الوضع الداكن';
  static const String mainPage = 'الصفحة الرئيسية';
  static const String nextPrayer = 'الصلاة القادمة';
  static const String remainingTime = 'الوقت المتبقي : ';
  static const String todayHadith = 'حديث اليوم';
  static const List<String> homeDrawerTextButtons = <String>[
    'ختم القرآن',
    'حلقه التسبيح',
    'التسبيح بعدالصلاة'
  ];
  static const List<String> adhkarList = <String>[
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'سبحان الله وبحمده',
    'سبحان الله العظيم',
    'أستغفر الله وأتوب إليه',
    'لا حول ولا قوة إلا بالله',
    'اللهم صل وسلم على نبينا محمد',
    'لا إله إلا أنت سبحانك إني كنت من الظالمين',
  ];
  static const String done = '✔';
  static const String khetmAlquran = '''
اللهم ارحمني بالقرآن، واجعله لي إمامًا ونورًا وهدًى ورحمة،
اللهم ذكرني منه ما نسيت، وعلمني منه ما جهلت، وارزقني تلاوته آناء الليل وأطراف النهار،
واجعله لي حجةً يا رب العالمين.

اللهم أصلح لي ديني الذي هو عصمة أمري، وأصلح لي دنياي التي فيها معاشي،
وأصلح لي آخرتي التي فيها معادي،
واجعل الحياة زيادةً لي في كل خير، واجعل الموت راحةً لي من كل شر.

اللهم اجعل خير عملي آخره، وخير أيامي يوم ألقاك فيه.

اللهم إني أسألك عيشةً هنية، وميتةً سوية، ومردًا غير مخزٍ ولا فاضح.

اللهم اجعلنا من الذين يُحلون حلاله، ويحرمون حرامه، ويعملون بمحكمه، ويؤمنون بمتشابهه،
اللهم اجعلنا ممن يقيم حروفه وحدوده، ولا تجعلنا ممن يقيم حروفه ويضيع حدوده.

اللهم اجعل القرآن العظيم ربيع قلوبنا، ونور صدورنا، وجلاء أحزاننا، وذهاب همومنا وغمومنا،
وسائقنا وقائدنا إلى رضوانك وإلى جناتك جنات النعيم.

اللهم ارزقنا تلاوة القرآن آناء الليل وأطراف النهار على الوجه الذي يرضيك عنا،
اللهم اجعلنا ممن يقرأه فيرقى، ولا تجعلنا ممن يقرأه فيشقى.

برحمتك يا أرحم الراحمين،
وصلى الله وسلم على نبينا محمد، وعلى آله وصحبه أجمعين.
''';

  static const List<String> namesOfPrayers1 = <String>[
    'فجر',
    'شروق',
    'ظهر',
    'عصر',
    'مغرب',
    'عشاء'
  ];

  static const List<String> imagesOfHomePageButtons = <String>[
    'assets/images/quran.png',
    'assets/images/quran.png',
    'assets/images/ramadan.png',
    'assets/images/mosque.png',
    'assets/images/compass.png'
  ];
  static const List<String> emojisOfPrayers = <String>[
    '🌙',
    '🌤',
    '☀️',
    "🌇",
    '🌥',
    '🌒'
  ];
  static const List supplicationIcons = [
    Icons.wb_sunny, // أذكار الصباح
    Icons.nightlight_round, // أذكار المساء
    Icons.check_circle_outline, // أذكار بعد السلام من الصلاة المفروضة
    Icons.spa, // تسابيح
    Icons.bedtime, // أذكار النوم
    Icons.alarm, // أذكار الاستيقاظ
    Icons.book, // أدعية قرآنية
    Icons.group, // أدعية الأنبياء
  ];
  static const List<String> adhkarButtonsNames = <String>[
    "أذكار الصباح",
    "أذكار المساء",
    "أذكار بعد السلام من الصلاة المفروضة",
    "تسابيح",
    "أذكار النوم",
    "أذكار الاستيقاظ",
    "أدعية قرآنية",
    "أدعية الأنبياء",
  ];
  static List pages = [
    BlocProvider(
        create: (context) => QuranCubit()..loadPdfFromAssets(),
        child: AlquranAlkarimPage()),
        SurahListPage(),
    ElecRosaryPage(),
    RamadanTabelPage(),
    QiblaPage(),
  ];
  //prayer times page
  static const String chooseDate = "اختر التاريخ";
  //   ===Alquran Alkarim Page===
  static const theIndex = 'الفهرس';
  static const Map<String, int> surahPages = {
    'الفاتحة': 1,
    'البقرة': 2,
    'آل عمران': 45,
    'النساء': 69,
    'المائدة': 95,
    'الأنعام': 115,
    'الأعراف': 136,
    'الأنفال': 160,
    'التوبة': 169,
    'يونس': 187,
    'هود': 199,
    'يوسف': 212,
    'الرعد': 225,
    'إبراهيم': 231,
    'الحجر': 237,
    'النحل': 242,
    'الإسراء': 255,
    'الكهف': 266,
    'مريم': 277,
    'طه': 286,
    'الأنبياء': 294,
    'الحج': 302,
    'المؤمنون': 311,
    'النور': 319,
    'الفرقان': 329,
    'الشعراء': 335,
    'النمل': 345,
    'القصص': 354,
    'العنكبوت': 364,
    'الروم': 371,
    'لقمان': 377,
    'السجدة': 381,
    'الأحزاب': 383,
    'سبأ': 393,
    'فاطر': 399,
    'يس': 404,
    'الصافات': 410,
    'ص': 417,
    'الزمر': 422,
    'غافر': 431,
    'فصلت': 439,
    'الشورى': 445,
    'الزخرف': 451,
    'الدخان': 457,
    'الجاثية': 460,
    'الأحقاف': 464,
    'محمد': 486,
    'الفتح': 472,
    'الحجرات': 477,
    'ق': 479,
    'الذاريات': 482,
    'الطور': 485,
    'النجم': 487,
    'القمر': 490,
    'الرحمن': 493,
    'الواقعة': 496,
    'الحديد': 499,
    'المجادلة': 504,
    'الحشر': 507,
    'الممتحنة': 510,
    'الصف': 513,
    'الجمعة': 515,
    'المنافقون': 516,
    'التغابن': 518,
    'الطلاق': 520,
    'التحريم': 522,
    'الملك': 524,
    'القلم': 526,
    'الحاقة': 529,
    'المعارج': 531,
    'نوح': 533,
    'الجن': 535,
    'المزمل': 537,
    'المدثر': 538,
    'القيامة': 540,
    'الإنسان': 542,
    'المرسلات': 544,
    'النبأ': 545,
    'النازعات': 547,
    'عبس': 549,
    'التكوير': 550,
    'الانفطار': 551,
    'المطففين': 552,
    'الانشقاق': 553,
    'البروج': 554,
    'الطارق': 555,
    'الأعلى': 556,
    'الغاشية': 557,
    'الفجر': 557,
    'البلد': 559,
    'الشمس': 559,
    'الليل': 560,
    'الضحى': 561,
    'الشرح': 561,
    'التين': 562,
    'العلق': 562,
    'القدر': 563,
    'البينة': 563,
    'الزلزلة': 564,
    'العاديات': 564,
    'القارعة': 565,
    'التكاثر': 565,
    'العصر': 566,
    'الهمزة': 566,
    'الفيل': 566,
    'قريش': 567,
    'الماعون': 567,
    'الكوثر': 567,
    'الكافرون': 568,
    'النصر': 568,
    'المسد': 568,
    'الإخلاص': 569,
    'الفلق': 569,
    'الناس': 569,
  };

  static const List<Map<String, String>> tafsirEditions = [
  {'identifier': 'ar.tabari', 'name': 'تفسير الطبري'},
  {'identifier': 'ar.mukhtasar', 'name': 'المختصر في التفسير'},
  {'identifier': 'ar.muyassarghareeb', 'name': 'الميسر في الغريب'},
  {'identifier': 'ar.tanwiralmiqbas', 'name': 'تنوير المقباس من تفسير بن عباس'},
  {'identifier': 'ar.ibnkathir', 'name': 'تفسير ابن كثير'},
  {'identifier': 'ar.wasit', 'name': 'التفسير الوسيط'},
  {'identifier': 'ar.saddi', 'name': 'تفسير السعدي'},
  {'identifier': 'ar.baghawi', 'name': 'تفسير البغوي'},
  {'identifier': 'ar.muyassar', 'name': 'التفسير الميسر المجمع'},
  {'identifier': 'ar.qurtubi', 'name': 'تفسير القرطبي'},
  {'identifier': 'ar.jalalayn', 'name': 'تفسير الجلالين'},
  {'identifier': 'ar.qatayba', 'name': 'غريب القرآن لابن قتيبة'},
  {'identifier': 'ar.ibnashur', 'name': 'تفسير ابن عاشور'},
];


  static const List<Map<String, dynamic>> surahs = [
    {'name': 'الفاتحة', 'page': 1, 'ayahs': 7, 'type': 'مكية'},
    {'name': 'البقرة', 'page': 2, 'ayahs': 286, 'type': 'مدنية'},
    {'name': 'آل عمران', 'page': 45, 'ayahs': 200, 'type': 'مدنية'},
    {'name': 'النساء', 'page': 69, 'ayahs': 176, 'type': 'مدنية'},
    {'name': 'المائدة', 'page': 95, 'ayahs': 120, 'type': 'مدنية'},
    {'name': 'الأنعام', 'page': 115, 'ayahs': 165, 'type': 'مكية'},
    {'name': 'الأعراف', 'page': 136, 'ayahs': 206, 'type': 'مكية'},
    {'name': 'الأنفال', 'page': 160, 'ayahs': 75, 'type': 'مدنية'},
    {'name': 'التوبة', 'page': 169, 'ayahs': 129, 'type': 'مدنية'},
    {'name': 'يونس', 'page': 187, 'ayahs': 109, 'type': 'مكية'},
    {'name': 'هود', 'page': 199, 'ayahs': 123, 'type': 'مكية'},
    {'name': 'يوسف', 'page': 212, 'ayahs': 111, 'type': 'مكية'},
    {'name': 'الرعد', 'page': 225, 'ayahs': 43, 'type': 'مدنية'},
    {'name': 'إبراهيم', 'page': 231, 'ayahs': 52, 'type': 'مكية'},
    {'name': 'الحجر', 'page': 237, 'ayahs': 99, 'type': 'مكية'},
    {'name': 'النحل', 'page': 242, 'ayahs': 128, 'type': 'مكية'},
    {'name': 'الإسراء', 'page': 255, 'ayahs': 111, 'type': 'مكية'},
    {'name': 'الكهف', 'page': 266, 'ayahs': 110, 'type': 'مكية'},
    {'name': 'مريم', 'page': 277, 'ayahs': 98, 'type': 'مكية'},
    {'name': 'طه', 'page': 286, 'ayahs': 135, 'type': 'مكية'},
    {'name': 'الأنبياء', 'page': 294, 'ayahs': 112, 'type': 'مكية'},
    {'name': 'الحج', 'page': 302, 'ayahs': 78, 'type': 'مدنية'},
    {'name': 'المؤمنون', 'page': 311, 'ayahs': 118, 'type': 'مكية'},
    {'name': 'النور', 'page': 319, 'ayahs': 64, 'type': 'مدنية'},
    {'name': 'الفرقان', 'page': 329, 'ayahs': 77, 'type': 'مكية'},
    {'name': 'الشعراء', 'page': 335, 'ayahs': 227, 'type': 'مكية'},
    {'name': 'النمل', 'page': 345, 'ayahs': 93, 'type': 'مكية'},
    {'name': 'القصص', 'page': 354, 'ayahs': 88, 'type': 'مكية'},
    {'name': 'العنكبوت', 'page': 364, 'ayahs': 69, 'type': 'مكية'},
    {'name': 'الروم', 'page': 371, 'ayahs': 60, 'type': 'مكية'},
    {'name': 'لقمان', 'page': 377, 'ayahs': 34, 'type': 'مكية'},
    {'name': 'السجدة', 'page': 381, 'ayahs': 30, 'type': 'مكية'},
    {'name': 'الأحزاب', 'page': 383, 'ayahs': 73, 'type': 'مدنية'},
    {'name': 'سبأ', 'page': 393, 'ayahs': 54, 'type': 'مكية'},
    {'name': 'فاطر', 'page': 399, 'ayahs': 45, 'type': 'مكية'},
    {'name': 'يس', 'page': 404, 'ayahs': 83, 'type': 'مكية'},
    {'name': 'الصافات', 'page': 410, 'ayahs': 182, 'type': 'مكية'},
    {'name': 'ص', 'page': 417, 'ayahs': 88, 'type': 'مكية'},
    {'name': 'الزمر', 'page': 422, 'ayahs': 75, 'type': 'مكية'},
    {'name': 'غافر', 'page': 431, 'ayahs': 85, 'type': 'مكية'},
    {'name': 'فصلت', 'page': 439, 'ayahs': 54, 'type': 'مكية'},
    {'name': 'الشورى', 'page': 445, 'ayahs': 53, 'type': 'مكية'},
    {'name': 'الزخرف', 'page': 451, 'ayahs': 89, 'type': 'مكية'},
    {'name': 'الدخان', 'page': 457, 'ayahs': 59, 'type': 'مكية'},
    {'name': 'الجاثية', 'page': 460, 'ayahs': 37, 'type': 'مكية'},
    {'name': 'الأحقاف', 'page': 464, 'ayahs': 35, 'type': 'مكية'},
    {'name': 'محمد', 'page': 486, 'ayahs': 38, 'type': 'مدنية'},
    {'name': 'الفتح', 'page': 472, 'ayahs': 29, 'type': 'مدنية'},
    {'name': 'الحجرات', 'page': 477, 'ayahs': 18, 'type': 'مدنية'},
    {'name': 'ق', 'page': 479, 'ayahs': 45, 'type': 'مكية'},
    {'name': 'الذاريات', 'page': 482, 'ayahs': 60, 'type': 'مكية'},
    {'name': 'الطور', 'page': 485, 'ayahs': 49, 'type': 'مكية'},
    {'name': 'النجم', 'page': 487, 'ayahs': 62, 'type': 'مكية'},
    {'name': 'القمر', 'page': 490, 'ayahs': 55, 'type': 'مكية'},
    {'name': 'الرحمن', 'page': 493, 'ayahs': 78, 'type': 'مدنية'},
    {'name': 'الواقعة', 'page': 496, 'ayahs': 96, 'type': 'مكية'},
    {'name': 'الحديد', 'page': 499, 'ayahs': 29, 'type': 'مدنية'},
    {'name': 'المجادلة', 'page': 504, 'ayahs': 22, 'type': 'مدنية'},
    {'name': 'الحشر', 'page': 507, 'ayahs': 24, 'type': 'مدنية'},
    {'name': 'الممتحنة', 'page': 510, 'ayahs': 13, 'type': 'مدنية'},
    {'name': 'الصف', 'page': 513, 'ayahs': 14, 'type': 'مدنية'},
    {'name': 'الجمعة', 'page': 515, 'ayahs': 11, 'type': 'مدنية'},
    {'name': 'المنافقون', 'page': 516, 'ayahs': 11, 'type': 'مدنية'},
    {'name': 'التغابن', 'page': 518, 'ayahs': 18, 'type': 'مدنية'},
    {'name': 'الطلاق', 'page': 520, 'ayahs': 12, 'type': 'مدنية'},
    {'name': 'التحريم', 'page': 522, 'ayahs': 12, 'type': 'مدنية'},
    {'name': 'الملك', 'page': 524, 'ayahs': 30, 'type': 'مكية'},
    {'name': 'القلم', 'page': 526, 'ayahs': 52, 'type': 'مكية'},
    {'name': 'الحاقة', 'page': 529, 'ayahs': 52, 'type': 'مكية'},
    {'name': 'المعارج', 'page': 531, 'ayahs': 44, 'type': 'مكية'},
    {'name': 'نوح', 'page': 533, 'ayahs': 28, 'type': 'مكية'},
    {'name': 'الجن', 'page': 535, 'ayahs': 28, 'type': 'مكية'},
    {'name': 'المزمل', 'page': 537, 'ayahs': 20, 'type': 'مكية'},
    {'name': 'المدثر', 'page': 538, 'ayahs': 56, 'type': 'مكية'},
    {'name': 'القيامة', 'page': 540, 'ayahs': 40, 'type': 'مكية'},
    {'name': 'الإنسان', 'page': 542, 'ayahs': 31, 'type': 'مدنية'},
    {'name': 'المرسلات', 'page': 544, 'ayahs': 50, 'type': 'مكية'},
    {'name': 'النبأ', 'page': 545, 'ayahs': 40, 'type': 'مكية'},
    {'name': 'النازعات', 'page': 547, 'ayahs': 46, 'type': 'مكية'},
    {'name': 'عبس', 'page': 549, 'ayahs': 42, 'type': 'مكية'},
    {'name': 'التكوير', 'page': 550, 'ayahs': 29, 'type': 'مكية'},
    {'name': 'الانفطار', 'page': 551, 'ayahs': 19, 'type': 'مكية'},
    {'name': 'المطففين', 'page': 552, 'ayahs': 36, 'type': 'مكية'},
    {'name': 'الانشقاق', 'page': 553, 'ayahs': 25, 'type': 'مكية'},
    {'name': 'البروج', 'page': 554, 'ayahs': 22, 'type': 'مكية'},
    {'name': 'الطارق', 'page': 555, 'ayahs': 17, 'type': 'مكية'},
    {'name': 'الأعلى', 'page': 556, 'ayahs': 19, 'type': 'مكية'},
    {'name': 'الغاشية', 'page': 557, 'ayahs': 26, 'type': 'مكية'},
    {'name': 'الفجر', 'page': 557, 'ayahs': 30, 'type': 'مكية'},
    {'name': 'البلد', 'page': 559, 'ayahs': 20, 'type': 'مكية'},
    {'name': 'الشمس', 'page': 559, 'ayahs': 15, 'type': 'مكية'},
    {'name': 'الليل', 'page': 560, 'ayahs': 21, 'type': 'مكية'},
    {'name': 'الضحى', 'page': 561, 'ayahs': 11, 'type': 'مكية'},
    {'name': 'الشرح', 'page': 561, 'ayahs': 8, 'type': 'مكية'},
    {'name': 'التين', 'page': 562, 'ayahs': 8, 'type': 'مكية'},
    {'name': 'العلق', 'page': 562, 'ayahs': 19, 'type': 'مكية'},
    {'name': 'القدر', 'page': 563, 'ayahs': 5, 'type': 'مكية'},
    {'name': 'البينة', 'page': 563, 'ayahs': 8, 'type': 'مدنية'},
    {'name': 'الزلزلة', 'page': 564, 'ayahs': 8, 'type': 'مدنية'},
    {'name': 'العاديات', 'page': 564, 'ayahs': 11, 'type': 'مكية'},
    {'name': 'القارعة', 'page': 565, 'ayahs': 11, 'type': 'مكية'},
    {'name': 'التكاثر', 'page': 565, 'ayahs': 8, 'type': 'مكية'},
    {'name': 'العصر', 'page': 566, 'ayahs': 3, 'type': 'مكية'},
    {'name': 'الهمزة', 'page': 566, 'ayahs': 9, 'type': 'مكية'},
    {'name': 'الفيل', 'page': 566, 'ayahs': 5, 'type': 'مكية'},
    {'name': 'قريش', 'page': 567, 'ayahs': 4, 'type': 'مكية'},
    {'name': 'الماعون', 'page': 567, 'ayahs': 7, 'type': 'مكية'},
    {'name': 'الكوثر', 'page': 567, 'ayahs': 3, 'type': 'مكية'},
    {'name': 'الكافرون', 'page': 568, 'ayahs': 6, 'type': 'مكية'},
    {'name': 'النصر', 'page': 568, 'ayahs': 3, 'type': 'مدنية'},
    {'name': 'المسد', 'page': 568, 'ayahs': 5, 'type': 'مكية'},
    {'name': 'الإخلاص', 'page': 569, 'ayahs': 4, 'type': 'مكية'},
    {'name': 'الفلق', 'page': 569, 'ayahs': 5, 'type': 'مكية'},
    {'name': 'الناس', 'page': 569, 'ayahs': 6, 'type': 'مكية'},
  ];

  //   ===adhkar page===
  static const String fontSizeButtonText = "ض";
  static const String adhkarPageSwitchText = "الحذف بعد الانتهاء";
  //   ===ramadan table===
  static const List<String> namesOfPrayers = <String>[
    'فجر',
    'ظهر',
    'عصر',
    'مغرب',
    'عشاء'
  ];
  static const List<String> namesOfVoluntaryPrayers = <String>[
    'السنن\nرواتب',
    'الشروق',
    'الضحى',
    'قيام\nالليل'
  ];
  static const List<String> supplications = <String>[
    'الصباح',
    'المساء',
    'الاستغفار',
    'الصلاة\nعلى\nالنبى',
    'اذكار\nعامة\nودعاء'
  ];
  static const List<String> list = <String>['ورد\nتلاوة', 'ورد\nتدبر'];
  static const String portraitOrientationToRTablePageText =
      'لإستخدام جدول رمضان يجب تفعيل التوجيه العرضي للموبايل.';
  //   ===elec rosary===
  static const String featuerdRecords = 'الريكوردات المميزه';
  static const String deleteAll = '  حذف الكل';
  static const String yes = 'نعم';
  static const String no = 'لا';
  static const String areYouSure = 'هل أنت متأكد؟';
  static const String emptyList = 'القائمه فارغه';
}
