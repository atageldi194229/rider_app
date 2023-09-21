import 'dart:async';
import 'dart:developer';

import 'package:asman_rider/env/env.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import 'package:location/location.dart';
import 'package:protos/protos.dart';

part 'location_tracker_event.dart';
part 'location_tracker_state.dart';

class LocationTrackerBloc extends Bloc<LocationTrackerEvent, LocationTrackerState> {
  LocationTrackerBloc() : super(const LocationTrackerState.initial()) {
    on<LocationTrackerStartRequested>(_onStartRequested);
    on<LocationTrackerStopRequested>(_onStopRequested);
  }

  /// Initialize GPS location
  final Location _location = Location();

  /// GRPC client
  ClientChannel? _channel;

  /// Tracker client
  TrackerClient? _stub;

  /// Stream to send [LocationRequest]
  StreamController<LocationRequest>? _locationStream;

  /// Timer for sending [LocationRequest] to server
  Timer? _timer;

  Future<void> _sendLocationToServer(LocationTrackerStartRequested event) async {
    log("Trying to send location...");

    final locationData = await _location.getLocation();

    var request = LocationRequest()
      ..date = DateTime.now().toIso8601String()
      ..latitude = locationData.latitude.toString()
      ..longitude = locationData.longitude.toString()
      ..speed = locationData.speed.toString()
      ..memberId = event.riderId.toString()
      ..warehouseId = event.warehouseId.toString();

    _locationStream?.add(request);
  }

  Future<bool> _hasLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    await _location.enableBackgroundMode(enable: true);

    return true;
  }

  void _stopTracking() {
    // timer stop
    _timer?.cancel();
    _timer = null;

    // stream close
    _locationStream?.close();
    _locationStream = null;

    // grpc client close
    _channel?.shutdown();
    _channel = null;
  }

  Future<void> _startTracking(LocationTrackerStartRequested event) async {
    try {
      /// check for location permission
      if (!(await _hasLocationPermission())) return;

      /// stop old tracking if exist
      _stopTracking();

      /// start new timer
      _timer = Timer.periodic(Duration(seconds: event.sendIntervalInSeconds), (_) => _sendLocationToServer(event));

      /// start new grpc client
      _channel = ClientChannel(
        Env.grpcUrl,
        port: Env.grpcPort,
        options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );

      /// Tracker Client (GRPC)
      _stub = TrackerClient(_channel!);

      /// New stream for sending location
      _locationStream = StreamController();

      /// Connect stream with tracker client
      final response = _stub!.updateLocation(_locationStream!.stream);

      /// For Logging purposes
      int counter = 0;
      response.listen(
        (value) {
          counter++;
          log("counter: $counter, response: $value");
        },
        onError: (error) async {
          log("Stream Error: $error", error: error);

          await Future.delayed(const Duration(seconds: 1));
          if (state.status == LocationTrackerStatus.tracking) {
            add(LocationTrackerStartRequested(
              riderId: event.riderId,
              warehouseId: event.warehouseId,
              sendIntervalInSeconds: event.sendIntervalInSeconds,
            ));
          }
        },
        onDone: () {
          log("Stream done}");
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      await Future.delayed(const Duration(seconds: 1));
      if (state.status == LocationTrackerStatus.tracking) {
        add(LocationTrackerStartRequested(
          riderId: event.riderId,
          warehouseId: event.warehouseId,
          sendIntervalInSeconds: event.sendIntervalInSeconds,
        ));
      }
    }
  }

  /// On Tracker Start Requested
  FutureOr<void> _onStartRequested(LocationTrackerStartRequested event, Emitter<LocationTrackerState> emit) {
    _startTracking(event);
    emit(state.copyWith(status: LocationTrackerStatus.tracking));
  }

  /// On Tracker Stop Requested
  FutureOr<void> _onStopRequested(LocationTrackerStopRequested event, Emitter<LocationTrackerState> emit) {
    _stopTracking();
    emit(state.copyWith(status: LocationTrackerStatus.stopped));
  }

  @override
  Future<void> close() {
    _stopTracking();
    return super.close();
  }
}
