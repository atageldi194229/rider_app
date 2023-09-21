import 'package:data_provider/data_provider.dart';

/// Line status client of user
class ProfileClient {
  /// Constructor
  const ProfileClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  /// Fetch rides (or Trips)
  Future<RiderStateResponse> getState() async {
    final response = await _http.get<Map<String, dynamic>>('/api/riders/state');
    return RiderStateResponse.fromJson(response.data!);
  }
}
