import 'package:string_similarity/string_similarity.dart';

abstract class IStringSimilarityService {
  double calculateSimilarity(String text1, String text2);
}

class StringSimilarityService implements IStringSimilarityService {
  @override
  double calculateSimilarity(String text1, String text2) {
    return text1.similarityTo(text2); // نسبة من 0 إلى 1
  }
}
