import 'package:data_provider/data_provider.dart';

/// Line status client of user
class RideClient {
  /// Constructor
  const RideClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  /// Fetch rides (or Trips)
  Future<RidePoolResponse> pool({int? page}) async {
    final response = await _http.get<Map<String, dynamic>>(
      '/api/riders/ride/pool',
      queryParameters: {
        'page': page,
      },
    );
    return RidePoolResponse.fromJson(response.data!);
  }

  /// Fetch Ride (or Trip) detail
  Future<RideDetailResponse> detail(int rideId) async {
    final response = await _http.get<Map<String, dynamic>>(
      '/api/riders/ride/detail/$rideId',
    );
    return RideDetailResponse.fromJson(response.data!);
  }

  /// Start Ride (or Trip)
  Future<void> start(int rideId) async {
    await _http.post<Map<String, dynamic>>(
      '/api/riders/ride/start',
      data: {
        'trip_id': rideId,
      },
    );
  }

  /// Pause Ride (or Trip)
  Future<void> pause(int rideId) async {
    await _http.post<Map<String, dynamic>>(
      '/api/riders/ride/pause',
      data: {
        'trip_id': rideId,
      },
    );
  }

  /// Transfer Ride (or Trip)
  Future<void> transfer(int rideId) async {
    await _http.post<Map<String, dynamic>>(
      '/api/riders/ride/transfer',
      data: {
        'trip_id': rideId,
      },
    );
  }

  /// Complete Ride (or Trip)
  Future<void> complete(int rideId) async {
    await _http.post<Map<String, dynamic>>(
      '/api/riders/ride/complete',
      data: {
        'trip_id': rideId,
      },
    );
  }

  /// Set order status at the address
  Future<void> pointArrive(int pointId) async {
    await _http.post<Map<String, dynamic>>(
      '/api/riders/ride/point/arrive',
      data: {
        'point_id': pointId,
      },
    );
  }

  /// Complete the order point
  Future<void> pointComplete(RidePointCompleteRequest data) async {
    await _http.post<Map<String, dynamic>>(
      '/api/riders/ride/point/complete',
      data: data.toJson(),
    );
  }

  /// Get history list
  Future<HistoryResponse> getHistory({int? page}) async {
    final response = await _http.get<Map<String, dynamic>>(
      '/api/riders/ride/history/list',
      queryParameters: {
        'page': page,
      },
    );

    return HistoryResponse.fromJson(response.data!);
  }
}
