import 'package:bloc/bloc.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/usecases/get_surah_with_tafsir_use_case.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';

class TafsirCubit extends Cubit<TafsirState> {
  final GetSurahWithTafsirUseCase getSurahWithTafsirUseCase;

  TafsirCubit(this.getSurahWithTafsirUseCase) : super(TafsirInitial());

  List<TafsirAyahEntity> ayahs = [];
  int currentOffset = 0;
  final int limit = 10;
  bool isLoadingMore = false;
  bool hasMore = true;
  late TafsirRequestParams baseParams;

  // لاستدعاء التفسير لأول مرة
  Future<void> getSurahWithTafsir(TafsirRequestParams params) async {
    if (!isClosed) {
      emit(TafsirLoading());
    }

    baseParams = params;
    currentOffset = 0;
    hasMore = true;
    ayahs.clear();

    final result = await getSurahWithTafsirUseCase(
      parameters: params.copyWith(offset: currentOffset, limit: limit),
    );

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(TafsirError(failure.message));
        }
      },
      (data) {
        ayahs = data;
        if (!isClosed) {
          emit(TafsirLoaded(List.from(ayahs)));
        }
      },
    );
  }

  // للتحميل عند التمرير
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;

    // Emit الحالة الحالية مع isLoadingMore=true
    if (!isClosed) {
      emit(TafsirLoaded(List.from(ayahs), isLoadingMore: true));
    }

    currentOffset += limit;

    final result = await getSurahWithTafsirUseCase(
      parameters: baseParams.copyWith(offset: currentOffset, limit: limit),
    );

    result.fold(
      (failure) {
        isLoadingMore = false;
        if (!isClosed) {
          emit(TafsirError(failure.message));
        }
      },
      (data) {
        if (data.isEmpty) {
          hasMore = false;
        } else {
          ayahs.addAll(data);
        }

        isLoadingMore = false;

        // Emit بعد التحميل
        if (!isClosed) {
          emit(TafsirLoaded(List.from(ayahs)));
        }
      },
    );
  }
}
