part of 'ride_bloc.dart';

abstract class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object?> get props => [];
}

class RideRequested extends RideEvent {}

class RideRefreshRequested extends RideEvent {}
