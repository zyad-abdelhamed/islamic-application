import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_state.dart';


class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(const BookmarkInitial()){
     formKey = GlobalKey<FormState>();
     controller = TextEditingController();
  }
  
 late final TextEditingController controller;
 late final GlobalKey<FormState> formKey;

 String? validateBookmark(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "الرجاء إدخال اسم العلامة";
  }
    return null;
}


  void saveBookmark() {
    // if (value.trim().isEmpty || value.trim().length > 20) {
    //   validateBookmark(value);
    //   return;
    // }
    // // هنا تقدر تحفظ العلامة (Database, SharedPreferences...)
    // emit(BookmarkSaved(value.trim()));
  }
}
