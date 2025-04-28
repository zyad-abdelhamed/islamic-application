import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/pages/alquran_alkarim_page.dart';
import 'package:test_app/features/app/presentation/view/pages/elec_rosary_page.dart';
import 'package:test_app/features/app/presentation/view/pages/rtabel_page.dart';

abstract class AppStrings {
  //   ===genral===
  static List<String> appBarTitles({required bool withTwoLines}) {
    String getNewlineOrWightSpace() => withTwoLines ? '\n ' : ' ';
    return <String>[
      'القرآن${getNewlineOrWightSpace()}الكريم',
      'السبحه${getNewlineOrWightSpace()}الالكترونيه',
      'جدول${getNewlineOrWightSpace()}رمضان',
      'القبله'
    ];
  }
  //   ===splash screen===
  static const String loadingText = 'يتم التحميل...';
  //   ===home page===
  static const String mainPage = 'الصفحة الرئيسية';
  static const String nextPrayer = 'الصلاة القادمة :';
  static const String remainingTime = 'الوقت المتبقي : ';
  static const List<String> homeDrawerTextButtons = <String>[
    'التسابيح بعدالصلاة',
    'حلقه التسبيح',
    'ختم القرآن'
  ];

  static const List<String> ringRosaryTexts = <String>[
    " سبحان الله",
    " الحمد لله",
    " الله أكبر",
    'لا إله إلا الله'
  ];
  static const String done = '';
  static const String khetmAlquran =
      'اللَّهُمَّ ارْحَمْنِي بالقُرْءَانِ وَاجْعَلهُ لِي إِمَامًا وَنُورًا وَهُدًى وَرَحْمَةً اللَّهُمَّ ذَكِّرْنِي مِنْهُ مَانَسِيتُ وَعَلِّمْنِي مِنْهُ مَاجَهِلْتُ وَارْزُقْنِي تِلاَوَتَهُ آنَاءَ اللَّيْلِ وَأَطْرَافَ النَّهَارِ وَاجْعَلْهُ';

  static const List<String> namesOfPrayers1 = <String>[
    'فجر',
    'شروق',
    'ظهر',
    'عصر',
    'مغرب',
    'عشاء'
  ];

  static const List<String> imagesOfHomePageButtons = <String>[
    'assets/images/quran.jpg',
    'assets/images/image.jpeg',
    'assets/images/ramadan.jpg',
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
  static const List<String> supplicationsButtonsNames = <String>[
    "أذكار الصباح",
    "أذكار المساء",
    "أذكار بعد السلام من الصلاة المفروضة",
    "تسابيح",
    "أذكار النوم",
    "أذكار الاستيقاظ",
    "أدعية قرآنية",
    "أدعية الأنبياء",
  ];
  static const List<StatelessWidget> pages = <StatelessWidget>[
    AlquranAlkarimPage(),
    ElecRosaryPage(),
    RamadanTabelPage()
  ];
  //   ===Alquran Alkarim Page===
  static const theIndex = 'الفهرس';
  static const Map<String, int> surahPages = {
    'الفاتحة': 1,
    'البقرة': 2,
    'آل عمران': 50,
    'النساء': 77,
    'المائدة': 106,
    'الأنعام': 128,
    'الأعراف': 151,
    'الأنفال': 177,
    'التوبة': 187,
    'يونس': 208,
    'هود': 221,
    'يوسف': 235,
    'الرعد': 249,
    'إبراهيم': 255,
    'الحجر': 262,
    'النحل': 267,
    'الإسراء': 282,
    'الكهف': 293,
    'مريم': 305,
    'طه': 312,
    'الأنبياء': 322,
    'الحج': 332,
    'المؤمنون': 342,
    'النور': 350,
    'الفرقان': 359,
    'الشعراء': 367,
    'النمل': 377,
    'القصص': 385,
    'العنكبوت': 396,
    'الروم': 404,
    'لقمان': 411,
    'السجدة': 415,
    'الأحزاب': 418,
    'سبأ': 428,
    'فاطر': 434,
    'يس': 440,
    'الصافات': 446,
    'ص': 453,
    'الزمر': 458,
    'غافر': 467,
    'فصلت': 477,
    'الشورى': 483,
    'الزخرف': 489,
    'الدخان': 496,
    'الجاثية': 499,
    'الأحقاف': 502,
    'محمد': 507,
    'الفتح': 511,
    'الحجرات': 515,
    'ق': 518,
    'الذاريات': 520,
    'الطور': 523,
    'النجم': 526,
    'القمر': 528,
    'الرحمن': 531,
    'الواقعة': 534,
    'الحديد': 537,
    'المجادلة': 542,
    'الحشر': 545,
    'الممتحنة': 549,
    'الصف': 551,
    'الجمعة': 553,
    'المنافقون': 554,
    'التغابن': 556,
    'الطلاق': 558,
    'التحريم': 560,
    'الملك': 562,
    'القلم': 564,
    'الحاقة': 566,
    'المعارج': 568,
    'نوح': 570,
    'الجن': 572,
    'المزمل': 574,
    'المدثر': 575,
    'القيامة': 577,
    'الإنسان': 578,
    'المرسلات': 580,
    'النبأ': 582,
    'النازعات': 583,
    'عبس': 585,
    'التكوير': 586,
    'الانفطار': 587,
    'المطففين': 587,
    'الانشقاق': 589,
    'البروج': 590,
    'الطارق': 591,
    'الأعلى': 591,
    'الغاشية': 592,
    'الفجر': 593,
    'البلد': 594,
    'الشمس': 595,
    'الليل': 595,
    'الضحى': 596,
    'الشرح': 596,
    'التين': 597,
    'العلق': 597,
    'القدر': 598,
    'البينة': 598,
    'الزلزلة': 599,
    'العاديات': 599,
    'القارعة': 600,
    'التكاثر': 600,
    'العصر': 601,
    'الهمزة': 601,
    'الفيل': 601,
    'قريش': 602,
    'الماعون': 602,
    'الكوثر': 602,
    'الكافرون': 603,
    'النصر': 603,
    'المسد': 603,
    'الإخلاص': 604,
    'الفلق': 604,
    'الناس': 604,
  };
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
