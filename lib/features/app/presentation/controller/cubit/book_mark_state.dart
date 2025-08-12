import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object?> get props => [];
}

class BookmarksInitial extends BookmarksState {}

class BookmarksLoading extends BookmarksState {}

class BookmarksLoaded extends BookmarksState {
  final List<BookMarkEntity> bookmarks;

  const BookmarksLoaded(this.bookmarks);

  @override
  List<Object?> get props => [bookmarks];
}

class AddBookmarkLoading extends BookmarksState {}

class AddBookmarksuccess extends BookmarksState {}

class DeleteBookmarkLoading extends BookmarksState {}

class DeleteBookmarksuccess extends BookmarksState {}
class BookmarksError extends BookmarksState {
  final String message;

  const BookmarksError(this.message);

  @override
  List<Object?> get props => [message];
}
