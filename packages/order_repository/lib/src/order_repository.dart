// ignore_for_file: lines_longer_than_80_chars

import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

/// Base Failure class for Order repository failures
abstract class OrderFailure with EquatableMixin implements Exception {
  /// {@macro order_failure}
  const OrderFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object?> get props => [];
}

/// Thrown when order detail get failure
class GetOrderDetailFailure extends OrderFailure {
  /// {@macro get_order_detail_failure}
  const GetOrderDetailFailure(super.error);
}

/// Thrown when order lines get failure
class GetOrderLinesFailure extends OrderFailure {
  /// {@macro get_order_lines_failure}
  const GetOrderLinesFailure(super.error);
}

/// Thrown when order update failure
class UpdateOrderFailure extends OrderFailure {
  /// {@macro ipdate_order_failure}
  const UpdateOrderFailure(super.error);
}

/// Thrown when daily order reports get failure
class GetDailyOrderReportsFailure extends OrderFailure {
  /// {@macro get_daily_order_reports_failure}
  const GetDailyOrderReportsFailure(super.error);
}

/// Order Repository, Or another words Trip Repository
class OrderRepository {
  /// Contructor
  const OrderRepository({
    required OrderClient orderClient,
  }) : _orderClient = orderClient;

  final OrderClient _orderClient;

  /// Get Order detail information
  Future<OrderDetail> getDetail(int orderId) async {
    try {
      final response = await _orderClient.detail(orderId);
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetOrderDetailFailure(error), stackTrace);
    }
  }

  /// Get Order lines
  Future<OrderLines> getOrderLines(int orderId) async {
    try {
      final response = await _orderClient.fetchLines(orderId);
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetOrderLinesFailure(error), stackTrace);
    }
  }

  /// Change order line quantity
  Future<OrderLines> updateOrder(int orderId, int lineId, int quantity) async {
    try {
      final response = await _orderClient.updateOrder(orderId, lineId, quantity);
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateOrderFailure(error), stackTrace);
    }
  }

  /// Get daily order reports
  Future<List<DailyOrder>> getDailyOrders({
    DateTime? fromTime,
    DateTime? toTime,
  }) async {
    try {
      final response = await _orderClient.getDailyOrders(
        fromTime: fromTime,
        toTime: toTime,
      );
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetDailyOrderReportsFailure(error), stackTrace);
    }
  }
}
