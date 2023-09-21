import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:ride_repository/ride_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    required RideRepository rideRepository,
  })  : _rideRepository = rideRepository,
        super(const HistoryState.initial()) {
    on<HistoryRequested>(_onHistoryRequested);
    on<HistoryRefreshRequested>(_onRefreshRequested);
  }

  final RideRepository _rideRepository;

  FutureOr<void> _onHistoryRequested(HistoryRequested event, Emitter<HistoryState> emit) async {
    // emit(state.copyWith(status: HistoryStatus.loading));

    try {
      final content = await _rideRepository.getHistory(page: state.page + 1);

      emit(state.copyWith(
        status: HistoryStatus.populated,
        content: {...state.content, ...content}.toList(),
        page: state.page + 1,
        hasMoreContent: true,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: HistoryStatus.failure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onRefreshRequested(HistoryRefreshRequested event, Emitter<HistoryState> emit) {
    emit(state.copyWith(
      status: HistoryStatus.loading,
      content: [],
      page: 0,
      hasMoreContent: true,
    ));

    add(HistoryRequested());
  }
}
