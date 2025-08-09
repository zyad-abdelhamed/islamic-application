import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

sealed class TafsirState extends Equatable {
  const TafsirState();

  @override
  List<Object?> get props => [];
}

class TafsirInitial extends TafsirState {
  const TafsirInitial();
}

class TafsirLoading extends TafsirState {
  const TafsirLoading();
}

class TafsirLoaded extends TafsirState {
  final List<TafsirAyahEntity> tafsir;
  final bool isLoadingMore;

  const TafsirLoaded(this.tafsir, {this.isLoadingMore = false});

  @override
  List<Object?> get props => [tafsir, isLoadingMore];
}


class TafsirError extends TafsirState {
  final String message;

  const TafsirError(this.message);

  @override
  List<Object?> get props => [message];
}

