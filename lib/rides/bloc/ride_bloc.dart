import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:ride_repository/ride_repository.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  RideBloc({
    required RideRepository rideRepository,
  })  : _rideRepository = rideRepository,
        super(const RideState.initial()) {
    on<RideRequested>(_onRideRequested, transformer: sequential());
    on<RideRefreshRequested>(_onRideRefreshRequested, transformer: droppable());
  }

  final RideRepository _rideRepository;

  FutureOr<void> _onRideRequested(RideRequested event, Emitter<RideState> emit) async {
    if (!state.hasMoreRides) return;

    try {
      emit(state.copyWith(status: RideStatus.loading));

      final response = await _rideRepository.getRides(page: state.page + 1);
      final rides = response.data!;
      final updatedRides = [...state.rides, ...rides];
      final hasMoreRides = response.meta!.currentPage! < response.meta!.lastPage!;

      emit(state.copyWith(
        status: RideStatus.populated,
        rides: updatedRides,
        hasMoreRides: hasMoreRides,
        page: state.page + 1,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: RideStatus.failure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onRideRefreshRequested(RideRefreshRequested event, Emitter<RideState> emit) {
    emit(state.copyWith(
      status: RideStatus.loading,
      rides: [],
      hasMoreRides: true,
      page: 0,
    ));

    add(RideRequested());
  }
}
