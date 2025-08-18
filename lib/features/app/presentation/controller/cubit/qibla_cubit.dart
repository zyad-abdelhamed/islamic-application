import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/features/app/domain/entities/qipla_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_qipla_repo.dart';

part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  final BaseQiblaRepository qiblaRepository;
  StreamSubscription? _subscription;

  QiblaCubit(this.qiblaRepository) : super(QiblaInitial());

  void startQibla({LocationAccuracy accuracy = LocationAccuracy.high}) {
    if (!isClosed) {
      emit(QiblaLoading());
    }
    _subscription = qiblaRepository.listenToQibla(accuracy).listen((result) {
      result.fold((failure) {
        if (!isClosed) {
          emit(QiblaError(failure.message));
        }
      }, (entity) {
        if (!isClosed) {
          emit(QiblaLoaded(entity, accuracy));
        }
      });
    });
  }

  void changeAccuracy(LocationAccuracy currentAccuracy) {
    startQibla(accuracy: _getNextAccuracy(currentAccuracy));
  }

  LocationAccuracy _getNextAccuracy(LocationAccuracy current) {
    final options = [
      LocationAccuracy.low,
      LocationAccuracy.medium,
      LocationAccuracy.high,
      LocationAccuracy.best,
    ];
    final currentIndex = options.indexOf(current);
    final nextIndex = (currentIndex + 1) % options.length;
    return options[nextIndex];
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
