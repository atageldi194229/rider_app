// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_tracker_bloc.dart';

enum LocationTrackerStatus {
  initial,
  tracking,
  stopped,
  failure,
}

class LocationTrackerState extends Equatable {
  const LocationTrackerState({
    required this.status,
  });

  final LocationTrackerStatus status;

  const LocationTrackerState.initial() : this(status: LocationTrackerStatus.initial);

  @override
  List<Object> get props => [status];

  LocationTrackerState copyWith({
    LocationTrackerStatus? status,
  }) {
    return LocationTrackerState(
      status: status ?? this.status,
    );
  }
}
