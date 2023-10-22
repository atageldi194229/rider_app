part of 'location_tracker_bloc.dart';

abstract class LocationTrackerEvent extends Equatable {
  const LocationTrackerEvent();

  @override
  List<Object?> get props => [];
}

class LocationTrackerStartRequested extends LocationTrackerEvent {
  final int riderId;
  final int warehouseId;
  final int? activeRideId;
  final int sendIntervalInSeconds;
  final String grpcUrl;

  const LocationTrackerStartRequested({
    required this.riderId,
    required this.warehouseId,
    required this.activeRideId,
    required this.sendIntervalInSeconds,
    required this.grpcUrl,
  });

  @override
  List<Object?> get props => [
        riderId,
        warehouseId,
        activeRideId,
        sendIntervalInSeconds,
        grpcUrl,
      ];
}

/// Called when need to stop tracking
class LocationTrackerStopRequested extends LocationTrackerEvent {}
