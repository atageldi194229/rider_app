// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_ride_bloc.dart';

enum ActiveRideStatus {
  initial,

  loading,
  populated,
  failure,

  completingRide,
  completingRideFailure,
  completingRideSucceeded,
}

class ActiveRideState extends Equatable {
  const ActiveRideState({
    required this.status,
    this.rideId,
  });

  const ActiveRideState.initial() : this(status: ActiveRideStatus.initial);

  final ActiveRideStatus status;
  final int? rideId;

  @override
  List<Object?> get props => [status, rideId];

  ActiveRideState copyWith({
    ActiveRideStatus? status,
    int? rideId,
  }) {
    return ActiveRideState(
      status: status ?? this.status,
      rideId: rideId ?? this.rideId,
    );
  }
}
