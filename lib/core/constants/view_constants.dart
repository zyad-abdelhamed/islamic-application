import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/pages/alquran_alkarim_page.dart';
import 'package:test_app/features/app/presentation/view/pages/elec_rosary_page.dart';
import 'package:test_app/features/app/presentation/view/pages/rtabel_page.dart';

abstract class ViewConstants {
  //genral
  static const Duration lowDuration = Duration(milliseconds: 100);
  static const Duration mediumDuration = Duration(milliseconds: 500);
  static const Duration longDuration = Duration(milliseconds: 1200);

  static const List<Duration> circleAvatarsDurations = <Duration>[
    Duration(milliseconds: 700),
    Duration(milliseconds: 900),
    Duration(milliseconds: 1100),
  ];
  static List<String> appBarTitles({required bool withTwoLines}) {
    String getNewlineOrWightSpace() => withTwoLines ? '\n ' : ' ';
    return <String>[
      'القرآن${getNewlineOrWightSpace()}الكريم',
      'السبحه${getNewlineOrWightSpace()}الالكترونيه',
      'جدول${getNewlineOrWightSpace()}رمضان',
      'القبله'
    ];
  }

  //splash screen
  static const String loadingText = 'يتم التحميل...';
  //home page
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
    Icons.wb_sunny,  // أذكار الصباح
    Icons.nightlight_round,  // أذكار المساء
    Icons.check_circle_outline,  // أذكار بعد السلام من الصلاة المفروضة
    Icons.spa,  // تسابيح
    Icons.bedtime,  // أذكار النوم
    Icons.alarm,  // أذكار الاستيقاظ
    Icons.book,  // أدعية قرآنية
    Icons.group,  // أدعية الأنبياء
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
  //ramadan table
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
  //elec rosary
  static const String emptyList = 'القائمه فارغه';
}
