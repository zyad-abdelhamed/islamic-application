import 'package:flutter/material.dart';

abstract class ViewConstants {
  //genral
  static const Duration duration = Duration(milliseconds: 100);
  static List<String> appBarTitles({required bool withTwoLines}) {
    String getNewlineOrWightSpace() => withTwoLines ? '\n ' : ' ';
    return <String>[
      'القرآن${getNewlineOrWightSpace()}الكريم',
      'السبحه${getNewlineOrWightSpace()}الالكترونيه',
      'جدول${getNewlineOrWightSpace()}رمضان'
    ];
  }

  //splash screen
  static const String loadingText = 'يتم التحميل...';
  //home page
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
