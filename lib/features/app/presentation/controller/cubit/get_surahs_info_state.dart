part of 'get_surahs_info_cubit.dart';

class GetSurahsInfoState extends Equatable {
  const GetSurahsInfoState({
    this.state = RequestStateEnum.loading,
    this.errorMessage = '',
    this.surahsInfo = const [],
  });

  final RequestStateEnum state;
  final String errorMessage;
  final List<SurahEntity> surahsInfo;

  GetSurahsInfoState copyWith({
    RequestStateEnum? state,
    String? errorMessage,
    List<SurahEntity>? surahsInfo,
  }) {
    return GetSurahsInfoState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      surahsInfo: surahsInfo ?? this.surahsInfo,
    );
  }

  @override
  List<Object?> get props => [
        state,
        errorMessage,
        surahsInfo,
      ];
}
