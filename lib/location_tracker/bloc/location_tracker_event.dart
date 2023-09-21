part of 'location_tracker_bloc.dart';

abstract class LocationTrackerEvent extends Equatable {
  const LocationTrackerEvent();

  @override
  List<Object> get props => [];
}

class LocationTrackerStartRequested extends LocationTrackerEvent {
  final int riderId;
  final int warehouseId;
  final int sendIntervalInSeconds;

  const LocationTrackerStartRequested({
    required this.riderId,
    required this.warehouseId,
    required this.sendIntervalInSeconds,
  });

  @override
  List<Object> get props => [riderId, warehouseId, sendIntervalInSeconds];
}

/// Called when need to stop tracking
class LocationTrackerStopRequested extends LocationTrackerEvent {}
