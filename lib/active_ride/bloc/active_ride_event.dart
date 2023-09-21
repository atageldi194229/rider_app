part of 'active_ride_bloc.dart';

/// Base event class for active ride
abstract class ActiveRideEvent extends Equatable {
  const ActiveRideEvent();

  @override
  List<Object> get props => [];
}

/// When ride is load or state is loaded
class ActiveRideLoaded extends ActiveRideEvent {
  final int rideId;

  const ActiveRideLoaded(this.rideId);

  @override
  List<Object> get props => [rideId];
}

/// Called when active ride is need to clear or empty
class ActiveRideEmptied extends ActiveRideEvent {}

/// When a new ride is started
class ActiveRideStartPressed extends ActiveRideEvent {
  final int rideId;

  const ActiveRideStartPressed(this.rideId);

  @override
  List<Object> get props => [rideId];
}

/// When a new ride is started
class ActiveRidePausePressed extends ActiveRideEvent {}

/// When a new ride is tranferred
class ActiveRideTransferPressed extends ActiveRideEvent {}

/// When an active ride is completed
class ActiveRideCompletePressed extends ActiveRideEvent {}
