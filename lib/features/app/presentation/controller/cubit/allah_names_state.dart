import 'package:test_app/features/app/domain/entities/allah_name.dart';

abstract class AllahNamesState {}

class AllahNamesStateInitial extends AllahNamesState {}

class AllahNamesStateIsToggleFavoriteSuccess extends AllahNamesState {}

class AllahNamesStateIsToggleFavoriteError extends AllahNamesState {
  final String message;

  AllahNamesStateIsToggleFavoriteError({
    required this.message,
  });
}

class GetRandomAllahName extends AllahNamesState {
  final AllahNameEntity current;

  GetRandomAllahName({
    required this.current,
  });
}
