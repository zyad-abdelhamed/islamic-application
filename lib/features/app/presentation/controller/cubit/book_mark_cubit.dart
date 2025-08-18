import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  final BaseQuranRepo repo;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController textEditingController;

  BookmarksCubit(this.repo) : super(BookmarksInitial()) {
    formKey = GlobalKey<FormState>();
    textEditingController = TextEditingController();
    loadBookmarks();
  }

  static BookmarksCubit controller(context) =>
      BlocProvider.of<BookmarksCubit>(context);

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء كتابة اسم العلامة';
    }
    return null;
  }

  Future<void> loadBookmarks() async {
    emit(BookmarksLoading());
    final result = await repo.getBookMarks();
    result.fold(
      (failure) => emit(BookmarksError(failure.message)),
      (bookmarks) => emit(BookmarksLoaded(bookmarks)),
    );
  }

  Future<void> addBookmark(QuranPageController quranPageController) async {
    if (formKey.currentState!.validate()) {
      emit(AddBookmarkLoading());
      final result = await repo.saveBookMark(
          bookmarkentity: BookMarkEntity(
              title: textEditingController.text,
              pageNumber: await quranPageController.pdfViewController.getCurrentPage() ?? 0,
              indexs: quranPageController.indexsNotifier.value.toList()));
      result.fold(
        (failure) => emit(BookmarksError(failure.message)),
        (_) => emit(AddBookmarksuccess()),
      );
    }
  }

  Future<void> deleteBookmarksList(List<int> indexs) async {
    emit(DeleteBookmarkLoading());
    final result = await repo.deleteBookmarksList(indexs: indexs);
    result.fold((failure) => emit(BookmarksError(failure.message)), (_) {
      emit(DeleteBookmarksuccess());
      loadBookmarks();
    });
  }

  Future<void> clearBookmarks() async {
    emit(DeleteBookmarkLoading());

    final result = await repo.clearBookMarks();
    result.fold((failure) => emit(BookmarksError(failure.message)), (_) {
      emit(DeleteBookmarksuccess());
      loadBookmarks();
    });
  }
}
