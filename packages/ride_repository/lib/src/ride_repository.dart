import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

/// Base Failure class for Ride repository failures
abstract class RideFailure with EquatableMixin implements Exception {
  /// {@macro ride_failure}
  const RideFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object?> get props => [error];
}

/// Thrown when rides get failure
class GetRidesFailure extends RideFailure {
  /// {@macro get_rides_failure}
  const GetRidesFailure(super.error);
}

/// Thrown when ride detail get failure
class GetRideDetailFailure extends RideFailure {
  /// {@macro get_ride_detail_failure}
  const GetRideDetailFailure(super.error);
}

/// Thrown when ride start failure
class StartRideFailure extends RideFailure {
  /// {@macro start_ride_failure}
  const StartRideFailure(super.error);
}

/// Thrown when ride pause failure
class PauseRideFailure extends RideFailure {
  /// {@macro pause_ride_failure}
  const PauseRideFailure(super.error);
}

/// Thrown when ride transfer failure
class TransferRideFailure extends RideFailure {
  /// {@macro transfer_ride_failure}
  const TransferRideFailure(super.error);
}

/// Thrown when ride complete failure
class CompleteRideFailure extends RideFailure {
  /// {@macro complete_ride_failure}
  const CompleteRideFailure(super.error);
}

/// Thrown when ride point arrive failure
class ArriveRidePointFailure extends RideFailure {
  /// {@macro arrive_ride_point_failure}
  const ArriveRidePointFailure(super.error);
}

/// Thrown when ride point complete failure
class CompleteRidePointFailure extends RideFailure {
  /// {@macro complete_ride_point_failure}
  const CompleteRidePointFailure(super.error);
}

/// Thrown when history fetch failure
class GetHistoryFailure extends RideFailure {
  /// {@macro get_history_failure}
  const GetHistoryFailure(super.error);
}

/// Ride Repository, Or another words Trip Repository
class RideRepository {
  /// Contructor
  const RideRepository({
    required RideClient rideClient,
  }) : _rideClient = rideClient;

  final RideClient _rideClient;

  /// To fetch rides or trips in other words
  Future<List<Ride>> getRides({int? page}) async {
    try {
      final response = await _rideClient.pool(page: page);
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetRidesFailure(error), stackTrace);
    }
  }

  /// To ride detail information
  Future<RideDetail> getDetail(int rideId) async {
    try {
      final response = await _rideClient.detail(rideId);
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetRideDetailFailure(error), stackTrace);
    }
  }

  /// Start ride
  Future<void> start(int rideId) async {
    try {
      await _rideClient.start(rideId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StartRideFailure(error), stackTrace);
    }
  }

  /// Pause ride
  Future<void> pause(int rideId) async {
    try {
      await _rideClient.pause(rideId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(PauseRideFailure(error), stackTrace);
    }
  }

  /// Transfer ride
  Future<void> transfer(int rideId) async {
    try {
      await _rideClient.transfer(rideId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(TransferRideFailure(error), stackTrace);
    }
  }

  /// Complete ride
  Future<void> complete(int rideId) async {
    try {
      await _rideClient.complete(rideId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(CompleteRideFailure(error), stackTrace);
    }
  }

  /// Ride point arrive
  Future<void> pointArrive(int pointId) async {
    try {
      await _rideClient.pointArrive(pointId);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ArriveRidePointFailure(error), stackTrace);
    }
  }

  /// Complete ride point
  Future<void> pointComplete(RidePointCompleteRequest data) async {
    try {
      await _rideClient.pointComplete(data);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(CompleteRidePointFailure(error), stackTrace);
    }
  }

  /// To fetch rides or trips history
  Future<List<HistoryItem>> getHistory({int? page}) async {
    try {
      final response = await _rideClient.getHistory(page: page);
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetHistoryFailure(error), stackTrace);
    }
  }
}
