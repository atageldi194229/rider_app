// ignore_for_file: lines_longer_than_80_chars

import 'package:data_provider/data_provider.dart';

/// Line status client of user
class OrderClient {
  /// Constructor
  const OrderClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  /// Fetch order detail
  Future<OrderDetailResponse> detail(int orderId) async {
    final response = await _http.get<Map<String, dynamic>>(
      '/api/riders/order/detail/$orderId',
    );
    return OrderDetailResponse.fromJson(response.data!);
  }

  /// Fetch order lines
  Future<OrderLinesResponse> fetchLines(int orderId) async {
    final response = await _http.get<Map<String, dynamic>>(
      '/api/riders/order/lines/$orderId',
    );
    return OrderLinesResponse.fromJson(response.data!);
  }

  /// Updating order, add and remove products from the order
  Future<OrderLinesResponse> updateOrder(int orderId, int lineId, int quantity) async {
    final response = await _http.put<Map<String, dynamic>>(
      '/api/riders/order/update',
      data: <String, dynamic>{
        'order_id': orderId,
        'line_id': lineId,
        'quantity': quantity,
      },
    );
    return OrderLinesResponse.fromJson(response.data!);
  }

  /// Gets daily reports of order
  Future<DailyOrderResponse> getDailyOrders() async {
    final response = await _http.get<Map<String, dynamic>>(
      '/api/riders/report/daily-orders',
    );

    return DailyOrderResponse.fromJson(response.data!);
  }
}
