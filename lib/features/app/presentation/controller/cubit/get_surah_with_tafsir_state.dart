import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';

abstract class GetSurahWithTafsirState extends Equatable {
  const GetSurahWithTafsirState();

  @override
  List<Object?> get props => [];
}

class GetSurahWithTafsirLoading extends GetSurahWithTafsirState {}

class GetSurahWithTafsirSuccess extends GetSurahWithTafsirState {
  final SurahWithTafsirEntity surahWithTafsir;

  const GetSurahWithTafsirSuccess(this.surahWithTafsir);

  @override
  List<Object?> get props => [surahWithTafsir];
}

class GetSurahWithTafsirFailure extends GetSurahWithTafsirState {
  final String message;

  const GetSurahWithTafsirFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GetSurahWithTafsirLoadingMore extends GetSurahWithTafsirState {}

class GetSurahWithTafsirNoMoreData extends GetSurahWithTafsirState {}
