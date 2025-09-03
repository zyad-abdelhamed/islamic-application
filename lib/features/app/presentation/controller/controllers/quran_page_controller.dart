import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';

class QuranPageController {
  late ValueNotifier<Set<int>> indexsNotifier;
  late PDFViewController pdfViewController;
  late final List surahsInfoList;
  void initState() {
    indexsNotifier = ValueNotifier<Set<int>>({});
  }

  Future<void> loadSurahs() async {
    surahsInfoList = await getJson(RoutesConstants.surahsJsonRouteName);
  }

  void setPdfController(PDFViewController controller) {
    pdfViewController = controller;
  }

  /// الميزة في هذه الطريقة:
  /// - نستخدم بحث ثنائي (Binary Search) للوصول لأول سورة بنفس الصفحة بسرعة كبيرة O(log n).
  /// - بعد ما نلاقي أول تطابق، نكمل لوب بسيط جدًا (O(k)) لجمع كل السور اللي صفحتها نفس الرقم.
  /// - الكود بسيط وسهل القراءة، والأداء ممتاز لأن k صغير (عادة 1 أو 2 سور فقط).
  /// - الطريقة دي أسرع بكثير من البحث الخطي العادي O(n) خصوصًا مع قوائم كبيرة.

  Set<int> updateIndexNotifier(BuildContext context, int pageNumber) {
    // هنخزن هنا كل إندكسات السور اللي صفحتها تساوي pageNumber
    final Set<int> indexes = {};

    // متغيرات البحث الثنائي
    int low = 0;
    int high = surahsInfoList.length - 1;
    int firstMatchIndex = -1; // هنا هنخزن أول مكان نلاقي فيه نفس الصفحة

    // بحث ثنائي للعثور على أول سورة بنفس الصفحة
    while (low <= high) {
      int mid = (low + high) >> 1; // قسمة على 2 لكن أسرع باستخدام البت شيفت
      int page = surahsInfoList[mid]["page"] - 1; // ننقص 1 لأن الصفحات 0-based

      if (page == pageNumber) {
        firstMatchIndex = mid;
        high = mid - 1; // نكمل نبحث في النصف الشمال عشان نلاقي أول تطابق
      } else if (page < pageNumber) {
        low = mid + 1; // الصفحة أكبر من المطلوب → نروح يمين
      } else {
        high = mid - 1; // الصفحة أصغر من المطلوب → نروح شمال
      }
    }

    // من أول تطابق، نجمع كل السور اللي صفحتها نفس الرقم
    for (int i = firstMatchIndex; i < surahsInfoList.length; i++) {
      if (surahsInfoList[i]["page"] - 1 == pageNumber) {
        indexes.add(surahsInfoList[i]["page"]);
      } else {
        break; // وقفنا أول ما الصفحات اختلفت (عشان نوفر وقت)
      }
    }

    // تحديث الـ Notifier والـ Controller لو فيه تطابقات
    if (indexes.isNotEmpty) {
      indexsNotifier.value = indexes;
      QuranCubit.getQuranController(context).updateIndex(indexes.toList());
    }

    return indexes;
  }

  void dispose() {
    indexsNotifier.dispose();
  }
}
