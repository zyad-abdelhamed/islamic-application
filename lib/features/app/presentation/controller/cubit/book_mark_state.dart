import 'package:equatable/equatable.dart';


abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}


class BookmarkInitial extends BookmarkState {
  const BookmarkInitial();
}

class BookmarkSavedLoading extends BookmarkState {
  const BookmarkSavedLoading();
}

class BookmarkSavedError extends BookmarkState {
  final String message;
  const BookmarkSavedError(this.message);

  @override
  List<Object> get props => [message];
}

class BookmarkSaved extends BookmarkState {
  final String name;
  const BookmarkSaved(this.name);

  @override
  List<Object> get props => [name];
}
