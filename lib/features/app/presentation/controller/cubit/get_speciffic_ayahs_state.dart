part of 'get_speciffic_ayahs_cubit.dart';

sealed class GetSpecifficAyahsState extends Equatable {
  const GetSpecifficAyahsState();

  @override
  List<Object> get props => [];
}

final class GetSpecifficAyahsInitial extends GetSpecifficAyahsState {}

final class GetSpecifficAyahsLoading extends GetSpecifficAyahsState {}

final class GetSpecifficAyahsSuccess extends GetSpecifficAyahsState {
  final List<AyahEntity> ayahsList;
  const GetSpecifficAyahsSuccess(this.ayahsList);
}

final class GetSpecifficAyahsFailure extends GetSpecifficAyahsState {
  final String message;
  const GetSpecifficAyahsFailure(this.message);
}
