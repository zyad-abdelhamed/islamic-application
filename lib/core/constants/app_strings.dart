import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/alquran_alkarim_page.dart';
import 'package:test_app/features/app/presentation/view/pages/elec_rosary_page.dart';
import 'package:test_app/features/app/presentation/view/pages/qibla_page.dart';
import 'package:test_app/features/app/presentation/view/pages/rtabel_page.dart';

abstract class AppStrings {
  //   ===genral===
  static List<String> appBarTitles({required bool withTwoLines}) {
    String getNewlineOrWightSpace() => withTwoLines ? '\n ' : ' ';
    return <String>[
      'القرآن${getNewlineOrWightSpace()}الكريم',
      'السبحه${getNewlineOrWightSpace()}الالكترونيه',
      'جدول${getNewlineOrWightSpace()}رمضان',
      'اتجاه${getNewlineOrWightSpace()}القبله'
    ];
  }
  static const String back = "العوده";
  //   ===on boarding===
  static const String skip = 'تخطى';
  static const String next = 'التالى';
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
  static const String nextPrayer = 'الصلاة القادمة :';
  static const String remainingTime = 'الوقت المتبقي : ';
  static const String todayHadith = 'حديث اليوم';
  static const List<String> homeDrawerTextButtons = <String>[
    'التسابيح بعدالصلاة',
    'حلقه التسبيح',
    'ختم القرآن'
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
  static  List pages = [
   BlocProvider(
        create: (context) => QuranCubit()..loadPdfFromAssets(),
        child:  AlquranAlkarimPage()),
    ElecRosaryPage(),
    RamadanTabelPage(),
    QiblaPage(),
  ];
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
