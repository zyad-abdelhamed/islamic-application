part of 'get_surahs_info_cubit.dart';

class GetSurahsInfoState extends Equatable {
  const GetSurahsInfoState(
      {this.state = RequestStateEnum.loading,
      this.errorMessage = '',
      this.surahsInfo = const [],
      this.searchList});

  final RequestStateEnum state;
  final String errorMessage;
  final List<SurahEntity> surahsInfo;
  final List<SurahEntity>? searchList;

  @override
  List<Object?> get props => [state, errorMessage, surahsInfo, searchList];
}
