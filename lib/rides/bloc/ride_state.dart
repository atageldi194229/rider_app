// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_bloc.dart';

enum RideStatus {
  initial,
  loading,
  populated,
  failure,
}

class RideState extends Equatable {
  const RideState({
    required this.status,
    this.rides = const [],
    this.hasMoreRides = true,
    this.page = 0,
  });

  const RideState.initial() : this(status: RideStatus.initial);

  final RideStatus status;
  final List<Ride> rides;
  final bool hasMoreRides;
  final int page;

  @override
  List<Object> get props => [status, rides, hasMoreRides, page];

  RideState copyWith({
    RideStatus? status,
    List<Ride>? rides,
    bool? hasMoreRides,
    int? page,
  }) {
    return RideState(
      status: status ?? this.status,
      rides: rides ?? this.rides,
      hasMoreRides: hasMoreRides ?? this.hasMoreRides,
      page: page ?? this.page,
    );
  }
}
