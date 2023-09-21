import 'package:data_provider/data_provider.dart';

/// Line status client of user
class LineStatusClient {
  /// Constructor
  const LineStatusClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  /// read line status of user
  Future<LineStatusResponse> getLineStatus() async {
    final response = await _http.get<Map<String, dynamic>>('/api/riders/line/status');
    return LineStatusResponse.fromJson(response.data!);
  }

  /// update line status of user
  Future<LineStatusResponse> updateLineStatus() async {
    final response = await _http.post<Map<String, dynamic>>('/api/riders/line/status');
    return LineStatusResponse.fromJson(response.data!);
  }
}
