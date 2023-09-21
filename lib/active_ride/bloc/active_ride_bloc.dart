import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ride_repository/ride_repository.dart';

part 'active_ride_event.dart';
part 'active_ride_state.dart';

class ActiveRideBloc extends Bloc<ActiveRideEvent, ActiveRideState> {
  ActiveRideBloc({
    required RideRepository rideRepository,
  })  : _rideRepository = rideRepository,
        super(const ActiveRideState.initial()) {
    on<ActiveRideEmptied>(_onActiveRideEmptied);
    on<ActiveRideLoaded>(_onActiveRideLoaded);
    on<ActiveRideStartPressed>(_onActiveRideStartPressed);
    on<ActiveRidePausePressed>(_onActiveRidePausePressed);
    on<ActiveRideTransferPressed>(_onActiveRideTransferPressed);
    on<ActiveRideCompletePressed>(_onActiveRidecCompletePressed);
  }

  final RideRepository _rideRepository;

  /// Active Ride Empty
  FutureOr<void> _onActiveRideEmptied(ActiveRideEmptied event, Emitter<ActiveRideState> emit) {
    emit(const ActiveRideState.initial());
  }

  FutureOr<void> _onActiveRideLoaded(ActiveRideLoaded event, Emitter<ActiveRideState> emit) {
    emit(state.copyWith(
      status: ActiveRideStatus.populated,
      rideId: event.rideId,
    ));
  }

  /// Start Ride
  FutureOr<void> _onActiveRideStartPressed(ActiveRideStartPressed event, Emitter<ActiveRideState> emit) async {
    try {
      emit(state.copyWith(status: ActiveRideStatus.loading));

      await _rideRepository.start(event.rideId);

      emit(state.copyWith(
        status: ActiveRideStatus.populated,
        rideId: event.rideId,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ActiveRideStatus.failure));
      addError(error, stackTrace);
    }
  }

  /// Pause Active Ride
  FutureOr<void> _onActiveRidePausePressed(ActiveRidePausePressed event, Emitter<ActiveRideState> emit) async {
    try {
      emit(state.copyWith(status: ActiveRideStatus.loading));

      await _rideRepository.pause(state.rideId!);

      emit(const ActiveRideState(
        status: ActiveRideStatus.populated,
        rideId: null,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ActiveRideStatus.failure));
      addError(error, stackTrace);
    }
  }

  /// Transfer Active Ride
  FutureOr<void> _onActiveRideTransferPressed(ActiveRideTransferPressed event, Emitter<ActiveRideState> emit) async {
    try {
      emit(state.copyWith(status: ActiveRideStatus.loading));

      await _rideRepository.transfer(state.rideId!);

      emit(const ActiveRideState(
        status: ActiveRideStatus.populated,
        rideId: null,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ActiveRideStatus.failure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onActiveRidecCompletePressed(ActiveRideCompletePressed event, Emitter<ActiveRideState> emit) async {
    try {
      emit(state.copyWith(status: ActiveRideStatus.completingRide));

      await _rideRepository.complete(state.rideId!);

      emit(const ActiveRideState(
        status: ActiveRideStatus.completingRideSucceeded,
        rideId: null,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ActiveRideStatus.completingRideFailure));
      addError(error, stackTrace);
    }
  }
}
