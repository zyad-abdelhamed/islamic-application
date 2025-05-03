import 'package:test_app/features/app/domain/entities/hadith.dart';

class HadithModel extends Hadith{
  const HadithModel({required super.content});

  factory HadithModel.fromJson(Map<String,dynamic> jsonHadith){
   return HadithModel(content: jsonHadith['arab']);
  }
}