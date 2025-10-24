import 'package:string_similarity/string_similarity.dart';

abstract class IStringSimilarityService {
  double calculateSimilarity(String text1, String text2);
}

class StringSimilarityService implements IStringSimilarityService {
  // إزالة التشكيل (064B-0652) + حذف superscript alef + tatweel
  String _removeDiacriticsAndExtras(String input) {
    if (input.isEmpty) return input;

    // احذف التشكيل
    final diacritics = RegExp(r'[\u064B-\u0652]');
    String s = input.replaceAll(diacritics, '');

    // احذف superscript alef (ٱ/ٰ) و tatweel (ـ)
    s = s.replaceAll('\u0670', ''); // superscript alef
    s = s.replaceAll('\u0640', ''); // tatweel

    // احذف أي رموز غير حرفية (رقم/علامات) مع ترك المسافات
    s = s.replaceAll(RegExp(r'[^\u0600-\u06FF\s]'), '');

    return s;
  }

  // توحيد أشكال الحروف (اختياري لكن مفيد)
  String _normalizeLetters(String input) {
    return input
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ئ', 'ي') // اختياري
        .replaceAll('ؤ', 'و'); // اختياري حسب رغبتك
  }

  String _normalizeText(String input) {
    var s = input.trim();
    s = _removeDiacriticsAndExtras(s);
    s = _normalizeLetters(s);
    // ازالة الفراغات الداخلية تمامًا لأن similarity يعمل أحسن على تسلسل الحروف
    s = s.replaceAll(RegExp(r'\s+'), '');
    return s;
  }

  @override
  double calculateSimilarity(String text1, String text2) {
    final cleanText1 = _normalizeText(text1);
    final cleanText2 = _normalizeText(text2);

    if (cleanText1.isEmpty || cleanText2.isEmpty) return 0.0;

    final similarity = cleanText1.similarityTo(cleanText2);

    print(
        '🔍 Target(clean): $cleanText1 | Spoken(clean): $cleanText2 | Similarity: $similarity');

    return similarity;
  }
}
