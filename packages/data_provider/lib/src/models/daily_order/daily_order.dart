// ignore_for_file: lines_longer_than_80_chars, sort_constructors_first, public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'daily_order.g.dart';

/// DailyOrder
@JsonSerializable()
class DailyOrder {
  /// Contructor
  const DailyOrder(
    this.day,
    this.count,
    this.discountTotal,
    this.subTotal,
    this.total,
    this.deliveryCost,
    this.workingTime,
    this.rating,
    this.earnings,
  );

  /// Day
  final String? day;

  /// Count
  final int? count;

  /// Discount total
  @JsonKey(name: 'discount_total')
  final String? discountTotal;

  /// Sub total
  @JsonKey(name: 'sub_total')
  final String? subTotal;

  /// Total
  final String? total;

  /// Delivery cost
  @JsonKey(name: 'delivery_cost')
  final String? deliveryCost;

  @JsonKey(name: 'working_time')
  final double? workingTime;

  final String? rating;

  final double? earnings;

  factory DailyOrder.fromJson(Map<String, dynamic> json) => _$DailyOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DailyOrderToJson(this);
}
